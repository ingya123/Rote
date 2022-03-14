//
//  UrlConnectionCommom.swift
//  VoteApp
//
//  Created by adam on 2021/11/30.
//

import Foundation


func urlCinnect(url: String, paramData: Dictionary<String, Any>) -> Dictionary<String, Any>{
    
    var returnData: String = ""
    var strData = ""
    var dicData: Dictionary<String, Any> = Dictionary<String, Any>()
    
    let paramData:String = dicToJson(dicData: paramData)
    
    do {
        
        func sendPost(paramText: String, urlString: String) -> String{
            // paramText를 데이터 형태로 변환
            let paramData = paramText.data(using: .utf8)

            // URL 객체 정의
            let url = URL(string: urlString)

            // URL Request 객체 정의
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.httpBody = paramData

            // HTTP 메시지 헤더
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue(String(paramData!.count), forHTTPHeaderField: "Content-Length")

            // URLSession 객체를 통해 전송, 응답값 처리
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // 서버가 응답이 없거나 통신이 실패
                if let e = error {
                  NSLog("An error has occured: \(e.localizedDescription)")
                  return
                }

                // 응답 처리 로직
                DispatchQueue.main.async() {
                    // 서버로부터 응답된 스트링 표시
                    let outputStr = String(data: data!, encoding: String.Encoding.utf8)
                    
                    returnData = outputStr!
                    print("result: \(returnData)")
                }
              
            }
            // POST 전송
            task.resume()
            
            return returnData
        }
        
        strData = sendPost(paramText: paramData, urlString: url)
        print("strData : \(returnData)")
        
    }
    print("dicData : \(returnData)")
    //dicData = jsonStrToDic(jsonStr: "["+returnData+"]")
    
    return dicData
}
