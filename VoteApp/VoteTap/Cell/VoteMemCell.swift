//
//  VoteMemCell.swift
//  VoteApp
//
//  Created by adam on 2021/12/31.
//

import UIKit

class VoteMemCell: UITableViewCell {
    @IBOutlet var name: UILabel!
    @IBOutlet var score: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
