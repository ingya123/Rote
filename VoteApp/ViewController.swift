//
//  ViewController.swift
//  VoteApp
//
//  Created by adam on 2021/11/08.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwdTextField: UITextField!
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var autoLoginBtn: UIButton!
    
    var totalMemberList: [[String: Any]] = []
    var autoLogin = true
    
    //로드 될 때 이벤트 발생
    override func viewDidLoad() {
        super.viewDidLoad()
        backTypeSwipe(nc: navigationController)
        //처음 버튼 세팅
        self.btnSetting()
        self.fnAutoLogin()

    }
    
    //뷰가 나타날 때 이벤트 발생
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        backTypeSwipe(nc: navigationController)
    }
    
    @IBAction func signBtnClick(_ sender: Any) {
         
        let storyboard: UIStoryboard = UIStoryboard(
            name: "SignUp",
            bundle: nil
        )
        
        let vc = storyboard.instantiateViewController(
            withIdentifier: "SignUpVC"
        )
        navigationController?.isNavigationBarHidden = false
        
        
        self.navigationController?.navigationBar.topItem?.title = "로그인"
        self.show(vc, sender: self)
    }
    
    //자동로그인 체크버튼
    @IBAction func autoCheckClick(_ sender: UIButton) {
        
        if self.autoLogin == true {
            self.autoLoginBtn.setImage(UIImage(systemName: "circle"), for: .normal)
            self.autoLogin = false
        } else {
            self.autoLoginBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            self.autoLogin = true
        }
        
    }
    
    //자동로그인 체크
    func fnAutoLogin() {
        // UserDefaults에 값이 있는 경우 가져와서 parameter로 넘김
        if let userId = UserDefaults.standard.string(forKey: "id"){
            self.idTextField.text = userId
            self.pwdTextField.text = UserDefaults.standard.string(forKey: "pwd")!
            greenButtonSet(uiButton: loginBtn, radius: 25.0)
            self.loginBtn(loginBtn)
        }
    }
    
    //로그인버튼 커스텀
    func btnSetting() {
        
        grayButtonSet(uiButton: loginBtn, radius: 25.0)
        
        //키보드 입력 할 때 반응해서 textFieldDidChange호출(버튼 색상 변경)
        self.idTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.pwdTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    //여기에 넣어야 textField가 정상적으로 변경 됨
    override func viewDidLayoutSubviews() {
        textBorder(textField: idTextField)
        textBorder(textField: pwdTextField)

    }
    
    //textField 디자인(밑줄)
    func textBorder(textField: UITextField) {
        let border = CALayer()
        let width = CGFloat(1.0)
        
        border.borderColor = UIColor(red: 141/255, green: 151/255, blue: 162/255, alpha: 1).cgColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)

        border.borderWidth = width

        textField.layer.addSublayer(border)

        textField.layer.masksToBounds = true
    }
    
    //키보드 입력할 때 반응해 버튼색상 변경해줌
    @objc func textFieldDidChange(_ sender: Any?) {
        
        if idTextField.text!.count != 0 && pwdTextField.text!.count != 0{
            greenButtonSet(uiButton: loginBtn, radius: 25.0)
            
        }else {
            grayButtonSet(uiButton: loginBtn, radius: 25.0)
        }
    }
    
    //키패드 return누르면 키패드 내려감
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //화면 클릭 시 키패드 내림 처리
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
    
    //로그인 버튼 클릭 시 반응
    @IBAction func loginBtn(_ sender: UIButton) {
        
        let id = self.idTextField.text!
        let pwd = self.pwdTextField.text!
        
        if id == "" {
            
            //alert 타이틀, 메시지
            let alert = UIAlertController(title: "아이디를 입력해주세요", message: "", preferredStyle: UIAlertController.Style.alert)
            
            //alert 버튼, 액션
            let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
                //해당 위치에 행동 적으면 실행됨
            }
            
            //alert에 액션 삽입
            alert.addAction(okAction)
            
            self.present(alert, animated: false, completion: nil)
        }else if pwd == "" {
            let alert = UIAlertController(title: "비밀번호를 입력해주세요", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
                
            }
            alert.addAction(okAction)
            
            self.present(alert, animated: false, completion: nil)
            
        }else {
            LoadingIndicator.showLoading()
            let result = signUpBizplay(id: id, pwd: pwd)!
            let rsltCd: String = result["RSLT_CD"]! as! String
            LoadingIndicator.hideLoading()
            //인증성공
            if rsltCd == "0000" {
                
                //자동로그인 체크상태면 아이디 패스워드 저장
                if autoLogin {
                    UserDefaults.standard.set(self.idTextField.text!, forKey: "id")
                    UserDefaults.standard.set(self.pwdTextField.text!, forKey: "pwd")
                }else {
                    UserDefaults.standard.removeObject(forKey: "id")
                    UserDefaults.standard.removeObject(forKey: "pwd")
                }
                
                let admYn: String = (result["RESP_DATA"] as! [String: Any])["ADM_YN"]! as! String
                
                //UserDfaults에 ID, 관리자여부 체크
                UserDefaults.standard.set(self.idTextField.text!, forKey: "loginId")
                UserDefaults.standard.set(admYn, forKey: "admYn")
                
                //관리자계정인 경우 관리화면으로 이동
                if admYn == "Y" {
                    guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "adminMain") as? AdminMainViewController else { return }
                    
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }else {
                    
                    guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MemberMenuVC") as? MemberMenuVC else { return }
                    
                    
                    //guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "voteControll") as? VoteControllViewController else { return }
                    
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
                
            }else {
                let alert = UIAlertController(title: result["RSLT_MSG"]! as? String, message: "", preferredStyle: UIAlertController.Style.alert)
                
                let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
                    
                }
                alert.addAction(okAction)
                
                self.present(alert, animated: false, completion: nil)
            }
            
        }
    }
    
    //로움 직원만 로그인 가능한 로직 추가 예정
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
    
    func isRoumMembers() {
        
    }
    
}


