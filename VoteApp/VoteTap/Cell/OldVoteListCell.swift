//
//  OldVoteListCell.swift
//  VoteApp
//
//  Created by adam on 2021/12/17.
//

import UIKit

class OldVoteListCell: UICollectionViewCell {
    @IBOutlet var listNum: UILabel!
    @IBOutlet var memberNm: UILabel!
    @IBOutlet var dateAdd: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.listNum.layer.masksToBounds = true
        self.listNum.layer.cornerRadius = 13.0
    }
}
