//
//  VoteControllVC.swift
//  VoteApp
//
//  Created by adam on 2021/12/31.
//

import UIKit

class VoteControllVC: UIViewController {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var voteMemTableView: UITableView!
    
    var voteMemList: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.voteMemTableView.delegate = self
        self.voteMemTableView.dataSource = self
        self.targetListSet()
    }
    
    //독서경영 대상자 세팅
    func targetListSet() {
        let result = lookupBookTarget(date: dateToString(date: Date(), format: "yyyyMMdd"), id: UserDefaults.standard.string(forKey: "loginId") ?? "")!
        let rsltCd: String = result["RSLT_CD"]! as! String
        let admYn = UserDefaults.standard.string(forKey: "admYn")
        
        
        //인증성공
        if rsltCd == "0000" {
            print("\(result)#######")
            let voteYn = (result["RESP_DATA"]! as! [String: Any])["VOTE_YN"]! as! String
            let startYn = isOptionalStr(value: isOptionalDic(value: result["RESP_DATA"])["START_YN"])
            
            //투표종료시 결과화면
            if startYn == "N" {
                guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "VoteWinnerVC") as? VoteWinnerVC else { return }
                
                self.navigationController?.pushViewController(nextVC, animated: false)
                
                
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
            
            for (index, dic) in rec.enumerated() {
                
                self.voteMemList.append(dic)
                
            }
            self.voteMemTableView.reloadData()
            
        }
    }

}

extension VoteControllVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.voteMemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VoteMemCell
        
        cell.name.text = self.voteMemList[indexPath.row]["USER_NM"] as? String
        
        return cell
    }
    
    
}

