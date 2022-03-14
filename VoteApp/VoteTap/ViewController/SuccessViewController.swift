//
//  SuccessViewController.swift
//  VoteApp
//
//  Created by adam on 2021/12/16.
//

import UIKit

protocol FnBack:  AnyObject {
    func fnBack()
}

class SuccessViewController: UIViewController {

    @IBOutlet var successBtn: UIButton!
    
    weak var fnBack: FnBack?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.isNavigationBarHidden = true
        greenButtonSet(uiButton: successBtn, radius: 15)
        //스와이프 뒤로가기 비활성화
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    //뷰가 사라질 때 실행
    override func viewWillDisappear(_ animated: Bool) {
        //스와이프 뒤로가기 활성화
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    //버튼 클릭 시 AdminMainViewController로 이동
    @IBAction func successBtnClick(_ sender: UIButton) {
        
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        
        for viewController in viewControllerStack {
            if let redView = viewController as? AdminMainViewController { self.navigationController?.popToViewController(redView, animated: true) }
            
            //있는거 스택 다 날리고 새로 화면
            //self.navigationController?.setViewControllers(<#T##viewControllers: [UIViewController]##[UIViewController]#>, animated: <#T##Bool#>)
            
        }

    }
    
    
}
