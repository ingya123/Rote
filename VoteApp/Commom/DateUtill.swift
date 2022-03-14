//
//  DateUtill.swift
//  VoteApp
//
//  Created by adam on 2021/12/14.
//

import Foundation

//전달해준 형식에 맞게 포멧
func dateToString(date: Date, format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.string(from: date)
}
