//
//  AdminMainViewController.swift
//  VoteApp
//
//  Created by adam on 2021/11/30.
//

import UIKit

class AdminMainViewController: UIViewController {

    @IBOutlet var adminPageBtn: UIButton!
    @IBOutlet var votePageBtn: UIButton!
    var str: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.adminPageBtn.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1).cgColor
        self.votePageBtn.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1).cgColor
        self.adminPageBtn.layer.borderWidth = 1.0
        self.votePageBtn.layer.borderWidth = 1.0
        self.adminPageBtn.layer.cornerRadius = 5.0
        self.votePageBtn.layer.cornerRadius = 5.0
        
    }
    
    //화면 클릭 시 키패드 내림 처리
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }

    @IBAction func AdminPageBtnClick(_ sender: UIButton) {
        
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "dateSelectPage") as? DateSelectViewController else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //투표화면
    @IBAction func voteBtnClick(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "voteControll") as? VoteControllViewController else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
