//
//  SearchViewController.swift
//  VoteApp
//
//  Created by adam on 2021/12/15.
//

import UIKit

protocol SendDataDelegate: AnyObject {
    func sendData(info: [String: Any])
}

class SearchViewController: UIViewController {

    @IBOutlet var searchView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var date: Date?
    var memberList: [[String: Any]] = []
    var searchMemberList: [[String: Any]] = []
    
    weak var delegate: SendDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.searchView.dataSource = self
        self.searchView.delegate = self
        self.searchBar.delegate = self
    }
    
    //검색된 이름 클릭 시 등록api 호출 후 정상일 시 추가하기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let member = searchMemberList[indexPath.row]
        let id = member["USER_ID"] as! String
        let nm = member["USER_NM"] as! String
        
        let result = addBookTarget(date: dateToString(date: date!, format: "yyyyMMdd"), id: id, name: nm)!
        
        let rsltCd: String = result["RSLT_CD"]! as! String
        
        //인증성공
        if rsltCd == "0000" {
            
            self.delegate?.sendData(info: member)
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            
        //이미 등록된 사용자
        } else if rsltCd == "0001" {
           
            let alert = UIAlertController(title: "이미 등록된 사용자 입니다.", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
                
            }
            alert.addAction(okAction)
            
            self.present(alert, animated: false, completion: nil)
            
        //존재하지 않는 사람
        }else if rsltCd == "0002" {
            
            let alert = UIAlertController(title: "존재하지 않는 회원입니다.", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
                
            }
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
    }
    

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    //tableView 스택 수 반환(배열 길이)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchMemberList.count
    }
    
    //tableView에 배열내용 전달
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.searchView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let text: String = self.searchMemberList[indexPath.row]["USER_NM"] as! String
        cell.textLabel?.text = text
        return cell
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    
    //검색어 변경 됐을 때
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchMemberList.removeAll()
        
        let text = self.searchBar.text!
        let textCnt = (text.count - 1)
        
        for member in memberList {
            let userName = member["USER_NM"] as! String
            
            if (userName.count-1) >= textCnt && textCnt >= 0 {
                
                let endIdx: String.Index = userName.index(userName.startIndex, offsetBy: textCnt)
                
                let searchText = String(userName[...endIdx])
                
                if text == searchText {
                    self.searchMemberList.append(member)
                }
            }
            
        }
        self.searchView.reloadData()
    }
    
    //취소버튼 클릭 시
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}




