//
//  VoteScoreCell.swift
//  VoteApp
//
//  Created by adam on 2021/12/22.
//

import UIKit

class VoteScoreCell: UITableViewCell {
    @IBOutlet var name: UILabel!
    @IBOutlet var score: UILabel!
    

    
    //cell 간격 조절
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 10.0
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
    }
}
