//
//  SignUpVC.swift
//  Rote
//
//  Created by adam on 2022/01/25.
//

import UIKit
import WebKit

class SignUpVC: UIViewController {

    @IBOutlet var webView: WKWebView!
    
    override func loadView() {
        super.loadView()
        
        webView = WKWebView(frame: self.view.frame)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.view = self.webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.bizplay.co.kr/comm_0001_30.act")
        let request = URLRequest(url: url!)
        //뒤로가기 제스쳐 허용
        self.webView?.allowsBackForwardNavigationGestures = true
        
        //자바스크립트 활성화
        webView.configuration.preferences.javaScriptEnabled = true
        webView.load(request)
        
    }
    
    //홈버튼 누를 시 메인으로
    @IBAction func homeBtn(_ sender: Any) {
        navigationController?.isNavigationBarHidden = true
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
}
    
    
    



extension SignUpVC: WKUIDelegate, WKNavigationDelegate {
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() } //모달창 닫힐때 앱 종료현상 방지.
        
        //alert 처리
        func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String,
                     initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void){
            let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler() }))
            self.present(alertController, animated: true, completion: nil) }

        //confirm 처리
        func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
            let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (action) in completionHandler(false) }))
            alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler(true) }))
            self.present(alertController, animated: true, completion: nil) }
        
        // href="_blank" 처리
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            
            if navigationAction.targetFrame == nil {
                
                webView.load(navigationAction.request)
                
            }
            return nil
            
        }
}
