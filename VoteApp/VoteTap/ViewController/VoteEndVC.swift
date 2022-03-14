//
//  VoteEndVC.swift
//  VoteApp
//
//  Created by adam on 2021/12/21.
//

import UIKit

class VoteEndVC: UIViewController {

    @IBOutlet var endBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.endBtn.layer.cornerRadius = 10.0
        
        //스와이프 뒤로가기 비활성화
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    //뷰가 사라질 때 실행
    override func viewWillDisappear(_ animated: Bool) {
        //스와이프 뒤로가기 활성화
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    @IBAction func endBtnClick(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
