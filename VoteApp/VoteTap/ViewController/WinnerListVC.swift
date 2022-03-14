//
//  WinnerListVC.swift
//  Rote
//
//  Created by adam on 2022/02/07.
//

import UIKit

class WinnerListVC: UIViewController {

    
    @IBOutlet var backView: UIView!
    @IBOutlet var winnerView: UITableView!
    @IBOutlet var okBtn: UIButton!
    
    var winnerList:[[String: String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.winnerView.delegate = self
        self.winnerView.dataSource = self
        
        //셀 줄 없애기
        self.winnerView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.winnerView.layer.cornerRadius = 10.0
        self.backView.layer.cornerRadius = 10.0
        //버튼세팅
        greenButtonSet(uiButton: okBtn, radius: 5.0)
        self.listSettsing()
    }
    
    //역대 우승자 세팅
    func listSettsing() {
        
        let result = voteWinnerList(dataLmt: "100", dataCnt: "0", date: "")!
        let rsltCd: String = result["RSLT_CD"]! as! String
        let respData = isOptionalDic(value: result["RESP_DATA"])
        print("ccccc\(rsltCd)")
        //인증성공
        if rsltCd == "0000" {
            self.winnerList = respData["REC"] as! [[String: String]]
        }
            
        
    }
    @IBAction func okBtnClick(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    

}

extension WinnerListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.winnerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = winnerView.dequeueReusableCell(withIdentifier: "WinnerTableCell", for: indexPath) as! WinnerTableCell
        
        cell.nameLB.text = self.winnerList[indexPath.row]["USER_NM"]
        cell.numLB.text = String(indexPath.row + 1)
        
        var regDt: String = isOptionalStr(value: self.winnerList[indexPath.row]["REG_DT"])
        regDt.insert(".", at: regDt.index(regDt.startIndex, offsetBy: 4))
        regDt.insert(".", at: regDt.index(regDt.endIndex, offsetBy: -2))
        cell.dateLB.text = regDt
        
        return cell
    }
}
