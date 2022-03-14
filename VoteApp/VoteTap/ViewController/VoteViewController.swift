//
//  VoteViewController.swift
//  VoteApp
//
//  Created by adam on 2021/11/16.
//

import UIKit

class VoteViewController: UIViewController, SendDataDelegate {
    
    weak var fnBackVoteView: FnBack?
    
    @IBOutlet var voteSituation: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var backView: UIView!
    @IBOutlet var memberText: UITextField!
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var memberTableView: UITableView!
    @IBOutlet var applyBtn: UIButton!
    
    var selectDate: Date?  //전달받을 날짜
    var newDateYn: String? //신규날짜 여부
    
    var members: [[String: Any]] = []
    var totalMemberList: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backTypeSwipe(nc: navigationController)
        self.memberText.addLeftPadding()
        self.roundView()
        self.memberTableView.dataSource = self
        self.memberTableView.delegate = self
        self.dateLabel.text = dateToString(date: selectDate!, format: "yyyy.MM.dd")
        self.memberSet()
        self.buttonSet()
        //textField 클릭 시 이벤트 발생시키기
        self.memberText.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
        self.totalMemberAdd()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(labelClick))
        self.voteSituation.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func labelClick(sender: UITapGestureRecognizer) {
        
        
    }

    
    //버튼 세팅
    func buttonSet() {
        if members.count > 0 {
            greenButtonSet(uiButton: self.applyBtn, radius: 10.0)
        } else {
            whiteButtonSet(uiButton: self.applyBtn, radius: 10.0)
        }
        
    }
    
    //이름 추가 후 콜백
    func sendData(info: [String : Any]) {
        
        self.members.append(info)
        self.memberTableView.reloadData()
        if self.members.count > 0 {
            greenButtonSet(uiButton: self.applyBtn, radius: 10.0)
        }
    }
    
    func totalMemberAdd() {
        let result = lookupTotalMember()!
        let rsltCd: String = result["RSLT_CD"]! as! String
        
        //인증성공
        if rsltCd == "0000" {
            
            let respData: [String: Any] = result["RESP_DATA"]! as! [String: Any]
            let rec: [[String: Any]] = respData["REC"]! as! [[String: Any]]
            
            for dic in rec {    
                let nm = dic["USER_NM"]!
                let id = dic["USER_ID"]!
                let userInfo: [String: Any] = ["USER_ID": id, "USER_NM": nm]
                
                totalMemberList.append(userInfo)
                
            }
        }
    }
    
    @objc func myTargetFunction(textField: UITextField) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "searchView") as? SearchViewController else { return }
        
        viewController.memberList = totalMemberList
        viewController.delegate = self
        viewController.date = selectDate
        self.present(viewController, animated: true, completion: nil)
    }
    
    func memberSet() {
        let result = lookupBookTarget(date: dateToString(date: self.selectDate!, format: "yyyyMMdd"), id: "")!
        
        let rsltCd: String = result["RSLT_CD"]! as! String
        
        //인증성공
        if rsltCd == "0000" {
            
            let respData: [String: Any] = result["RESP_DATA"]! as! [String: Any]
            let rec: [[String: Any]] = respData["REC"]! as! [[String: Any]]
            
            for (_ , dic) in rec.enumerated() {
                self.members.append(dic)
                self.memberTableView.reloadData()
            }
            
        }
    }
    
    
    //tableView 타이틀
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "금일 독서경영 발표자"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //UI둥글게
    private func roundView() {
        self.backView.layer.cornerRadius = 5.0
        self.addBtn.layer.cornerRadius = 15.0
        self.memberTableView.layer.cornerRadius = 5.0
        self.memberText.layer.cornerRadius = 5.0
    }
    
    //추가하기 버튼 클릭 시 발표자 추가
    @IBAction func addBtnClick(_ sender: UIButton) {
        
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "searchView") as? SearchViewController else { return }
        
        viewController.memberList = totalMemberList
        viewController.delegate = self
        viewController.date = selectDate
        
        self.present(viewController, animated: true, completion: nil)
        
    }
    
    //적용하기 버튼 클릭
    @IBAction func applyBtnClick(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "정말 적용 하시겠습니까?", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            
            self.voteAddStart()
        }
        
        let cencleAlert = UIAlertAction(title: "취소", style: .default) { (action) in }
        alert.addAction(cencleAlert)
        alert.addAction(okAction)
        self.present(alert, animated: false, completion: nil)
        
    }
    
    //독서경영 상태 시작으로 변경, 완료페이지로 이동
    func voteAddStart() {
        let result = isOptionalDic(value: voteStart(startYn: "Y", date: dateToString(date: selectDate!, format: "yyyyMMdd")))
        let rsltCd: String = result["RSLT_CD"]! as! String
        
        //인증성공
        if rsltCd == "0000" {
        
            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "successView") as? SuccessViewController else { return }
        
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    
    //화면 클릭 시 키패드 내림 처리
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }

}

extension VoteViewController: UITableViewDataSource, UITableViewDelegate {
    
    //tableView 스택 수 반환(배열 길이)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    //tableView에 배열내용 전달
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = memberTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let text: String = self.members[indexPath.row]["USER_NM"] as! String
        cell.textLabel?.text = text
        return cell
    }
    
    //tableView 슬라이딩 삭제 구현
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let memberId = members[indexPath.row]["USER_ID"] as! String
            let memberName = members[indexPath.row]["USER_NM"] as! String
            let removeDate = dateToString(date: selectDate!, format: "yyyyMMdd")
            let result = removeBookTarget(date: removeDate, id: memberId, name: memberName)!
            let rsltCd: String = result["RSLT_CD"]! as! String
            
            //인증성공
            if rsltCd == "0000" {
                members.remove(at: indexPath.row)
                memberTableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            
        } else if editingStyle == .insert {
                    
        }
    }
}


//텍스트필드 공간주기
extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
