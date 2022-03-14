//
//  VoteRsltInputVC.swift
//  VoteApp
//
//  Created by adam on 2021/12/21.
//

import UIKit

class VoteRsltInputVC: UIViewController {

    @IBOutlet var voteScListView: UITableView!
    @IBOutlet var voteCount: UILabel!
    @IBOutlet var uiView: UIView!
    @IBOutlet var uiTableView: UITableView!
    @IBOutlet var shareBtn: UIButton!
    
    var scoreCellList: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //스와이프 뒤로가기 비활성화
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.uiView.layer.cornerRadius = 10.0
        self.uiTableView.layer.cornerRadius = 10.0
        greenButtonSet(uiButton: self.shareBtn, radius: 10.0)
        self.voteScListView.delegate = self
        self.voteScListView.dataSource = self
        self.scoreCellSet()
    }
    
    func scoreCellSet() {
        
        let result = voteScore(date: dateToString(date: Date(), format: "yyyyMMdd"))!
        let rsltCd: String = result["RSLT_CD"]! as! String
        
        //인증성공
        if rsltCd == "0000" {
            
            let respData: [String: Any] = result["RESP_DATA"]! as! [String: Any]
            let rec: [[String: Any]] = respData["REC"]! as! [[String: Any]]
            self.scoreCellList.removeAll()
            for dic in rec {
                
                self.scoreCellList.append(dic)
            }
            self.voteCount.text = "투표자 : \(isOptionalStr(value: respData["CNT"]))명"
            self.voteScListView.reloadData()
        }
    }
    
    //점수 새로고침
    @IBAction func reloadBtnClick(_ sender: UIButton) {
        self.scoreCellSet()
        
    }
    
    //독서경영 결과처리
    @IBAction func shareBtnClick(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "정말 공유하시겠습니까?", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            self.voteShare()
        }
        
        let cencleAlert = UIAlertAction(title: "취소", style: .default) { (action) in }
        alert.addAction(cencleAlert)
        alert.addAction(okAction)
        self.present(alert, animated: false, completion: nil)
        
    }
    
    //제출하기 확인 클릭 시 결과처리
    func voteShare() {
        let result = voteEnd(date: dateToString(date: Date(), format: "yyyyMMdd"))!
        let rsltCd: String = result["RSLT_CD"]! as! String
        //인증성공
        if rsltCd == "0000" {
            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "VoteWinnerVC") as? VoteWinnerVC else { return }
            
            self.navigationController?.pushViewController(nextVC, animated: false)
            
        }
    }
    
}

extension VoteRsltInputVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreCellList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = voteScListView.dequeueReusableCell(withIdentifier: "VoteScoreCell", for: indexPath) as! VoteScoreCell
        cell.name.text = scoreCellList[indexPath.row]["USER_NM"]! as? String
        cell.score.text = scoreCellList[indexPath.row]["SCOR"]! as? String
        
        return cell
    }
    
    
}
