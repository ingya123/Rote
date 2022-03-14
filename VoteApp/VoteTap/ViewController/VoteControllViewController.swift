//
//  VoteControllViewController.swift
//  VoteApp
//
//  Created by adam on 2021/12/02.
//

import UIKit

protocol selectDelegate {

    func sendCell(selectText:UICollectionViewCell, str : String)
}

class VoteControllViewController: UIViewController, selectDelegate {
    
    //실행되면 선택된 Cell의
    func sendCell(selectText: UICollectionViewCell, str: String) {
        if let index = voteMemberListView.indexPath(for: selectText) {
            list[index.row]["SCOR"] = str
            
        }
    }
    
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var voteMemberList: UIView!
    @IBOutlet var voteMemberListView: UICollectionView!
    @IBOutlet var scoreSubmitBtn: UIButton!
    
    @IBOutlet var winnerView: UIView!
    @IBOutlet var winnerListView: UICollectionView!
    var list: [[String: Any]] = []
    var winnerList: [[String: String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.voteMemberList.layer.cornerRadius = 10.0
        self.winnerView.layer.cornerRadius = 10.0
        self.winnerListView.layer.cornerRadius = 10.0
        //버튼세팅
        greenButtonSet(uiButton: scoreSubmitBtn, radius: 5.0)
        //날짜 세팅
        self.dateLabel.text = dateToString(date: Date(), format: "yyyy.MM.dd")
        //현재날짜 발표자 세팅
        self.targetListSet()
        self.oldWinnerListSet()
        
        self.voteMemberListView.delegate = self
        self.voteMemberListView.dataSource = self
        self.winnerListView.delegate = self
        self.winnerListView.dataSource = self
        
    }
    
    //역대 수상자 리스트 세팅
    func oldWinnerListSet() {
        let result = voteWinnerList(dataLmt: "5", dataCnt: "0", date: "")!
        let rsltCd: String = result["RSLT_CD"]! as! String
        let respData = isOptionalDic(value: result["RESP_DATA"])
        
        //인증성공
        if rsltCd == "0000" {
            winnerList = respData["REC"] as! [[String: String]]
        }
        
    }
    
    //독서경영 대상자 세팅
    func targetListSet() {
        let result = lookupBookTarget(date: dateToString(date: Date(), format: "yyyyMMdd"), id: UserDefaults.standard.string(forKey: "loginId") ?? "")!
        let rsltCd: String = result["RSLT_CD"]! as! String
        let admYn = UserDefaults.standard.string(forKey: "admYn")
        
        //인증성공
        if rsltCd == "0000" {
            
            let voteYn = (result["RESP_DATA"]! as! [String: Any])["VOTE_YN"]! as! String
            let startYn = isOptionalStr(value: isOptionalDic(value: result["RESP_DATA"])["START_YN"])
            
            //투표종료시 결과화면
            if startYn == "N" {
                guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "VoteWinnerVC") as? VoteWinnerVC else { return }
                
                self.navigationController?.pushViewController(nextVC, animated: false)
                
            //아직 투표가 실행되지 않았을 때
            }else if startYn == "D" || startYn == ""{
                
                let alert = UIAlertController(title: "아직 투표가 시작되지 않았습니다.", message: "", preferredStyle: UIAlertController.Style.alert)
                
                let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
                    self.navigationController?.popViewController(animated: true)
                    
                }
                alert.addAction(okAction)
                self.present(alert, animated: false, completion: nil)
                
                
               
            //이미 투표한사람 투표완료화면으로
            }else if voteYn == "Y" {
                
                //어드민은 투표관리 페이지
                if admYn == "Y" {
                    guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "voteRsltInput") as? VoteRsltInputVC else { return }
                    
                    self.navigationController?.pushViewController(nextVC, animated: false)
                    
                } else {
                    guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CpltVC") as? CpltVC else { return }
                    
                    self.navigationController?.pushViewController(nextVC, animated: false)
                }
                
                return
            }
            
            let respData: [String: Any] = result["RESP_DATA"]! as! [String: Any]
            let rec: [[String: Any]] = respData["REC"]! as! [[String: Any]]
            
            for dic in rec {
                var dicData = dic
                dicData["SCOR"] = ""
                self.list.append(dicData)
                
            }
            self.voteMemberListView.reloadData()
            
        }else {
            
        }
    }
    
    @IBAction func scoreSubmit(_ sender: UIButton) {
        
        if scoreCheck() {
            
            let alert = UIAlertController(title: "정말 제출 하시겠습니까?", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
                self.memberAddScore()
            }
            
            let cencleAlert = UIAlertAction(title: "취소", style: .default) { (action) in }
            alert.addAction(cencleAlert)
            alert.addAction(okAction)
            self.present(alert, animated: false, completion: nil)
            
        } else {
            showToast(message: "점수를 입력해 주세요.", font: .systemFont(ofSize: 15), view: self.view)
        }
        
    }
    
    //점수제출
    func memberAddScore() {
        
        let id = UserDefaults.standard.string(forKey: "loginId") ?? ""
        let result = addScore(date: dateToString(date: Date(), format: "yyyyMMdd"), voterId: id, rec: self.list)!
        
        let rsltCd: String = result["RSLT_CD"]! as! String
        
        //인증성공
        if rsltCd == "0000" {
            let admYn = UserDefaults.standard.string(forKey: "admYn")
            if admYn == "Y" {
                guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "voteRsltInput") as? VoteRsltInputVC else { return }
                
                self.navigationController?.pushViewController(nextVC, animated: true)
                
            }else {
                guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "voteEnd") as? VoteEndVC else { return }
                
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
        
        
    }
    
    //점수 비어있는게 있는 지 체크
    func scoreCheck() -> Bool{
        var i: Int = 0
        while i < self.list.count {
            if self.list[i]["SCOR"] as! String == "" {
                return false
            }
            i += 1
        }
        return true
    }

    //화면 클릭 시 키패드 내림 처리
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
    
    
}

//텍스트필드 델리게이트
extension VoteControllViewController: UITextFieldDelegate {
    
    //textField 값이 변경 될 때
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        //2자리수 제한, 10 넘지못하게
        if textField.text!.count > 2 {
               textField.deleteBackward()
        }else if Int(textField.text!) ?? 0 > 10 {
            textField.deleteBackward()
        }
        
    }
      
}

// cell data
extension VoteControllViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == voteMemberListView {
            return list.count
        } else if collectionView == winnerListView {
            return winnerList.count
        }
        return 0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == voteMemberListView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VoteMemberCell
            cell.textField.delegate = self
            cell.name.text = (list[indexPath.row]["USER_NM"]! as! String)
            cell.name.textColor = UIColor(red: 45/255, green: 53/255, blue: 65/255, alpha: 1)
            cell.textField.backgroundColor = UIColor(red: 239/255, green: 242/255, blue: 245/255, alpha: 1)
            cell.delegate = self
            
            cell.textField.text = (list[indexPath.row]["SCOR"] as! String)
            
            return cell
            
        }else if collectionView == winnerListView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OldVoteListCell", for: indexPath) as! OldVoteListCell
            cell.listNum.text = String(indexPath.row + 1)
            cell.memberNm.text = winnerList[indexPath.row]["USER_NM"]
            var regDt: String = isOptionalStr(value: winnerList[indexPath.row]["REG_DT"])
            regDt.insert(".", at: regDt.index(regDt.startIndex, offsetBy: 4))
            regDt.insert(".", at: regDt.index(regDt.endIndex, offsetBy: -2))
            cell.dateAdd.text = regDt
            return cell
            
        }
        
        
        return UICollectionViewCell()
    }
    
    
}



extension VoteControllViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 90, height: 30)
    }
}

