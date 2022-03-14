//
//  ButtonSet.swift
//  VoteApp
//
//  Created by adam on 2021/12/08.
//

import Foundation
import UIKit

//버튼 기본
func greenButtonSet(uiButton: UIButton, radius: CGFloat) {
    uiButton.backgroundColor = UIColor(red: 28/255, green: 191/255, blue: 152/255, alpha: 1)
    uiButton.layer.cornerRadius = radius
    uiButton.setTitleColor(.white, for: .normal)
}

//버튼 비활성화 상태
func grayButtonSet(uiButton: UIButton, radius: CGFloat) {
    uiButton.backgroundColor = UIColor(red: 239/255, green: 242/255, blue: 245/255, alpha: 1)
    uiButton.layer.cornerRadius = radius
    uiButton.setTitleColor(UIColor(red: 141/255, green: 151/255, blue: 162/255, alpha: 1), for: .normal)
}


//버튼 비활성화 흰색
func whiteButtonSet(uiButton: UIButton, radius: CGFloat) {
    uiButton.backgroundColor = .white
    uiButton.layer.cornerRadius = radius
    uiButton.setTitleColor(UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1), for: .normal)
}
