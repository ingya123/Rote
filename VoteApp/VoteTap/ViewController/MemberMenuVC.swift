//
//  MemberMenuVC.swift
//  Rote
//
//  Created by adam on 2022/02/07.
//

import UIKit

class MemberMenuVC: UIViewController {

    @IBOutlet var winnerBtn: UIButton!
    @IBOutlet var voteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.winnerBtn.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1).cgColor
        self.winnerBtn.layer.borderWidth = 1.0
        self.winnerBtn.layer.cornerRadius = 5.0
        
        self.voteBtn.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1).cgColor
        self.voteBtn.layer.borderWidth = 1.0
        self.voteBtn.layer.cornerRadius = 5.0
    }

    @IBAction func winnerBtnClick(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "WinnerListVC") as? WinnerListVC else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func voteBtnClick(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "voteControll") as? VoteControllViewController else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
