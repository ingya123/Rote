//
//  JsonCommom.swift
//  VoteApp
//
//  Created by adam on 2021/11/30.
//

import Foundation

//Dictionary형식을 jsonString으로 반환
func dicToJson(dicData: Dictionary<String, Any>) -> String{
    var strData: String? = ""
    do {
        let profileJson = try JSONSerialization.data(withJSONObject: dicData, options: .prettyPrinted)
        
        strData = String(data: profileJson, encoding: .utf8)
        
    } catch {
        print(error.localizedDescription)
    }
    
    return strData!
}

//json형식 String을 Dictionary형식으로 반환
func jsonStrToDic(jsonStr: String) -> [String: Any]? {
    if let data = jsonStr.data(using: .utf8) {
    
        do {
            return try JSONSerialization.jsonObject(with: data, options : []) as? [String: Any]
           
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}


