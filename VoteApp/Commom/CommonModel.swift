//
//  CommonModel.swift
//  VoteApp
//
//  Created by adam on 2021/12/17.
//

import Foundation

struct API_001 {
    
    struct Request: Encodable {
        let device_id: String
    }
    
    struct Response: Decodable {
        let str: String
        
    }
    
}
