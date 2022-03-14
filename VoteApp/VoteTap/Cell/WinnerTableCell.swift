//
//  WinnerTableCell.swift
//  Rote
//
//  Created by adam on 2022/02/08.
//

import UIKit

class WinnerTableCell: UITableViewCell {
    @IBOutlet var numLB: UILabel!
    @IBOutlet var nameLB: UILabel!
    @IBOutlet var dateLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.numLB.layer.masksToBounds = true
        self.numLB.layer.cornerRadius = 13.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
