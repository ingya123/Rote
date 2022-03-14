//
//  UtillCommom.swift
//  VoteApp
//
//  Created by adam on 2021/12/14.
//

import Foundation
import UIKit

//백버튼 숨기고 스와이프 뒤로가기 활성화
func backTypeSwipe(nc: UINavigationController?) {
    nc?.isNavigationBarHidden = true
    nc?.interactivePopGestureRecognizer?.delegate = nil
}

//배열의 count가 0이면 0반환 0보다 크면 -1해서 반환(for문용)
func countInt(list: [Any]) -> Int{
    let cnt = list.count
    return cnt > 0 ? cnt-1:0
}

//[String: Any]? -> [String: Any] (nil 방지)
func isOptionalDic2(value OptionalValue: [String: Any]?) -> [String: Any]{
    
    guard let dic = OptionalValue else {
        return [:]
    }
    
    return dic
    
}

//[String: Any]? -> [String: Any] (nil 방지)
func isOptionalDic(value OptionalValue: Any?) -> [String: Any]{
    switch OptionalValue {
    case .none:
        return [:]
    case .some(let someValue):
        return someValue as! [String: Any]
    }
}

//String? -> String (nil 방지)
func isOptionalStr(value OptionalValue: Any?) -> String{
    switch OptionalValue {
    case .none:
        return ""
    case .some(let someValue):
        return someValue as! String
    }
}

//alert 기본
func simpleAlert(title: String, message: String, btnTitle: String) -> UIAlertController{
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    
    let okAction = UIAlertAction(title: btnTitle, style: .default) { (action) in
        
    }
    alert.addAction(okAction)
    
    return alert
}

//토스트팝업
func showToast(message : String, font: UIFont, view: UIView) {
    let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 75, y: view.frame.size.height-100, width: 150, height: 35))
    //toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds = true
    view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: { toastLabel.alpha = 0.0 }, completion: {(isCompleted) in toastLabel.removeFromSuperview()
        
    })
    
}




