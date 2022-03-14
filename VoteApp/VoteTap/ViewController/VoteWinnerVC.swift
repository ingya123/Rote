//
//  VoteWinnerVC.swift
//  VoteApp
//
//  Created by adam on 2021/12/24.
//

import UIKit

class VoteWinnerVC: UIViewController {
    
    @IBOutlet var rsltMent: UILabel!
    @IBOutlet var nextBtn: UIButton!
    
    private var winnerList: [String] = []
    private var nameList: [String] = []
    private let pointLabel = UILabel()
    var selectDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //스와이프 뒤로가기 비활성화
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        greenButtonSet(uiButton: self.nextBtn, radius: 10.0)
        self.winnerNameSet()
        
    }
    
    //뷰가 사라질 때 실행
    override func viewWillDisappear(_ animated: Bool) {
        //스와이프 뒤로가기 활성화
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    //우승자 세팅
    func winnerNameSet() {
        var winnerText = "오늘의 일등은\n"
        var scDate: Date?
        if(selectDate == nil) {
            scDate = Date()
        }else {
            scDate = selectDate
            winnerText = "\(dateToString(date: selectDate!, format: "yyyy년 MM월 dd일"))의 일등은\n"
        }
        
        let result = voteWinnerList(dataLmt: "10", dataCnt: "0", date: dateToString(date: scDate ?? Date() , format: "yyyyMMdd"))!
        let rsltCd: String = result["RSLT_CD"]! as! String
        
        //인증성공
        if rsltCd == "0000" {
            
            let rec = ((result["RESP_DATA"]! as! [String: Any])["REC"])! as! [[String: Any]]
            
            var name: String = ""
            var ment: String = ""
            for data in rec {
                name = "\" \(data["USER_NM"] as? String ?? "") \""
                ment = "\(name)입니다!\n"
                winnerList.append(ment)
                nameList.append(name)
                winnerText += ment
            }
            self.rsltMent.text = winnerText
        }
        
        
    }
    
    @IBAction func nextBtnClick(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
