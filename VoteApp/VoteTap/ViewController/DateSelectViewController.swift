//
//  DateSelectViewController.swift
//  VoteApp
//
//  Created by adam on 2021/12/08.
//

import UIKit

class DateSelectViewController: UIViewController, FnBack {
    func fnBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var addBtn: UIButton!
    
    private let datePicker = UIDatePicker()
    private var selectDate: Date? = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureDatePicker()
        greenButtonSet(uiButton: addBtn, radius: 25.0)
        dateTextField.layer.borderWidth = 1.0
        dateTextField.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1).cgColor
        dateTextField.layer.cornerRadius = 5.0
        self.dateTextField.text = dateToString(date: Date(), format: "yyyy년 MM월 dd일(EEEEE)")
    }
    
    //dateTextField클릭 시 datePicker 생성하기
    private func configureDatePicker() {
        //datePicker 생성
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        self.datePicker.locale = Locale(identifier: "ko-KR")
        
        //dateTextField클릭 시 생성한 datePicker 나타남
        self.dateTextField.inputView = self.datePicker
    }
    
    //datePicker가 변경 될 때 호출할 매서드
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formmater.locale = Locale(identifier: "ko_KR")
        self.selectDate = datePicker.date
        self.dateTextField.text = formmater.string(from: datePicker.date)
        //날짜가 변경 될 때마다 editingChanged호출
        self.dateTextField.sendActions(for: .editingChanged)
    }
    
    //적용하기 버튼 클릭
    @IBAction func addBtnClick(_ sender: UIButton) {
        
        //날짜 입력 안했을경우 alert창
        if dateTextField.text == "" {
            
            let alert = UIAlertController(title: "날짜를 입력해주세요", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            }
            
            alert.addAction(okAction)
            
            self.present(alert, animated: false, completion: nil)
          
        //이미 투표 종료된 날짜 일 경우 투표 결과페이지
        }else if(startCheck()) {
            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "VoteWinnerVC") as? VoteWinnerVC else { return }
            nextVC.selectDate = self.selectDate
            self.navigationController?.pushViewController(nextVC, animated: false)
        }else {
            
            let result = addDateBookTarget(date: dateToString(date: self.selectDate!, format: "yyyyMMdd"))!
            let rsltCd: String = result["RSLT_CD"]! as! String
            
            //인증성공
            if rsltCd == "0000" {
                
                guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "adminAddPage") as? VoteViewController else { return }
                
                nextVC.selectDate = self.selectDate
                nextVC.newDateYn = "Y"
                
                nextVC.fnBackVoteView = self
                self.navigationController?.pushViewController(nextVC, animated: true)
                
                
            //이미 등록된 일자일 경우
            }else if rsltCd == "0001" {
                
                guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "adminAddPage") as? VoteViewController else { return }
                
                nextVC.selectDate = self.selectDate
                nextVC.newDateYn = "N"
                
                nextVC.fnBackVoteView = self
                self.navigationController?.pushViewController(nextVC, animated: true)
                
            }
        }
        
    }
    
    //투표 종료여부 체크 종료되었을 때 true
    func startCheck() -> Bool{
        
        let result = lookupBookTarget(date: dateToString(date: self.selectDate!, format: "yyyyMMdd"), id: UserDefaults.standard.string(forKey: "loginId") ?? "")!
        let rsltCd: String = result["RSLT_CD"]! as! String
        
        
        //인증성공
        if rsltCd == "0000" {
            let startYn = isOptionalStr(value: isOptionalDic(value: result["RESP_DATA"])["START_YN"])
            
            //투표종료시 결과화면
            if startYn == "N" {
                return true
                
            }
        }
        return false
    }
    
    //화면 터치 시 키패드 내려감 처리
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
