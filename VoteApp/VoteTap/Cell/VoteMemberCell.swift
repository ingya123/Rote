//
//  VoteMemberCell.swift
//  VoteApp
//
//  Created by adam on 2021/12/13.
//

import Foundation
import UIKit

class VoteMemberCell: UICollectionViewCell{
    @IBOutlet var name: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var hideBtn: UIButton!
    var id: String?
    var delegate : selectDelegate?
    
    
    override func layoutSubviews() {

        super.layoutSubviews()
        self.textField.addTarget(self, action: #selector(textSelect), for: UIControl.Event.editingChanged)
    }
    
    //잠금버튼 클릭 시 이미지 변경, 글자색 변경
    @IBAction func lockBtnClick(_ sender: Any) {
        if self.hideBtn.currentImage?.isEqual(UIImage(named: "scorLock")) == true {
            
            self.hideBtn.setImage(UIImage(named: "scorLock.open"), for: .normal)
            self.textField.textColor = UIColor(red: 45/255, green: 53/255, blue: 65/255, alpha: 1)
        }else {
            self.hideBtn.setImage(UIImage(named: "scorLock"), for: .normal)
            
            self.textField.textColor = UIColor(red: 239/255, green: 242/255, blue: 245/255, alpha: 1)
        }
    }
    @objc func textSelect() {
        
        delegate?.sendCell(selectText: self, str: self.textField.text ?? "")
        
    }
}


