//
//  SemoApiCommom.swift
//  VoteApp
//
//  Created by adam on 2021/12/13.
//

import Foundation

private let httpUrl: String = "https://uatroumit.smjb.co.kr/ROUMITGate.do"
private let key: String = "20211109-roumit-8e-ba27-d106a67ec98b"

// MARK: 독서경영 투표시작
func voteStart(startYn: String, date: String) -> [String: Any]?{
    
    //roumit bizplay api url
    let url: String = httpUrl
    
    //요청값 세팅
    var reqData: Dictionary<String, Any> = Dictionary<String, Any>()
    reqData["START_YN"] = startYn
    reqData["REG_DT"] = date
    
    var paramData:Dictionary<String, Any> = Dictionary<String, Any>()
    
    paramData["CNTS_CRTS_KEY"] = key
    paramData["TRAN_NO"] = "BOOK_INFO_CHNG_SVC"
    paramData["ENC_YN"] = "N"
    paramData["REQ_DATA"] = reqData
    
    return sendPost(paramText: dicToJson(dicData: paramData), urlString: url)
}

// MARK: 독서경영 우승자 리스트 데이터건수, 데이터시작위치
func voteWinnerList(dataLmt: String, dataCnt: String, date: String) -> [String: Any]?{
    
    //roumit bizplay api url
    let url: String = httpUrl
    
    //요청값 세팅
    var reqData: Dictionary<String, Any> = Dictionary<String, Any>()
    reqData["DATA_LMT"] = dataLmt
    reqData["DATA_CNT"] = dataCnt
    reqData["REG_DT"] = date
    
    var paramData:Dictionary<String, Any> = Dictionary<String, Any>()
    
    paramData["CNTS_CRTS_KEY"] = key
    paramData["TRAN_NO"] = "BOOK_RSLT_SRCH_SVC"
    paramData["ENC_YN"] = "N"
    paramData["REQ_DATA"] = reqData
    
    return sendPost(paramText: dicToJson(dicData: paramData), urlString: url)
}

// MARK: 독서경영 종료
func voteEnd(date:String) -> [String: Any]?{
    
    //roumit bizplay api url
    let url: String = httpUrl
    
    //요청값 세팅
    var reqData: Dictionary<String, Any> = Dictionary<String, Any>()
    reqData["REG_DT"] = date
    
    var paramData:Dictionary<String, Any> = Dictionary<String, Any>()
    
    paramData["CNTS_CRTS_KEY"] = key
    paramData["TRAN_NO"] = "BOOK_RSLT_PROC_SVC"
    paramData["REQ_DATA"] = reqData
    
    return sendPost(paramText: dicToJson(dicData: paramData), urlString: url)
}

// MARK: 독서경영 점수 현황(결과) 조회
func voteScore(date:String) -> [String: Any]?{
    
    //roumit bizplay api url
    let url: String = httpUrl
    
    //요청값 세팅
    var reqData: Dictionary<String, Any> = Dictionary<String, Any>()
    reqData["REG_DT"] = date
    
    var paramData:Dictionary<String, Any> = Dictionary<String, Any>()
    
    paramData["CNTS_CRTS_KEY"] = key
    paramData["TRAN_NO"] = "BOOK_SCOR_SRCH_SVC"
    paramData["ENC_YN"] = "N"
    paramData["REQ_DATA"] = reqData
    
    return sendPost(paramText: dicToJson(dicData: paramData), urlString: url)
}

// MARK: 독서경영 점수 처리
func addScore(date:String, voterId: String, rec: [[String: Any]]) -> [String: Any]?{
    
    //roumit bizplay api url
    let url: String = httpUrl
    
    //요청값 세팅
    var reqData: Dictionary<String, Any> = Dictionary<String, Any>()
    reqData["REG_DT"] = date
    reqData["VOTER_ID"] = voterId
    reqData["REC"] = rec
    
    var paramData:Dictionary<String, Any> = Dictionary<String, Any>()
    
    paramData["CNTS_CRTS_KEY"] = key
    paramData["TRAN_NO"] = "BOOK_SCOR_PROC_SVC"
    paramData["ENC_YN"] = "N"
    paramData["REQ_DATA"] = reqData
    
    return sendPost(paramText: dicToJson(dicData: paramData), urlString: url)
}

// MARK: 비즈플레이에 등록된 직원 조회
func lookupTotalMember() -> [String: Any]?{
    
    //roumit bizplay api url
    let url: String = httpUrl
    
    //요청값 세팅
    var reqData: Dictionary<String, Any> = Dictionary<String, Any>()
    reqData["LOGIN_ID"] = "lloyd.song"
    reqData["USE_INTT_ID"] = "UTLZ_265389"
    
    var paramData:Dictionary<String, Any> = Dictionary<String, Any>()
    
    paramData["CNTS_CRTS_KEY"] = key
    paramData["TRAN_NO"] = "EMPL_LIST_SRCH_SVC"
    paramData["ENC_YN"] = "N"
    paramData["REQ_DATA"] = reqData
    
    return sendPost(paramText: dicToJson(dicData: paramData), urlString: url)
}

// MARK: url통신 할 data 세팅(독서경영 대상자 등록)
func addBookTarget(date: String, id: String, name: String) -> [String: Any]?{
    
    //roumit bizplay api url
    let url: String = httpUrl
    
    //요청값 세팅
    var reqData: Dictionary<String, Any> = Dictionary<String, Any>()
    reqData["PROC_GB"] = "I"
    reqData["REG_DT"] = date
    reqData["USER_ID"] = id
    reqData["USER_NM"] = name
    
    var paramData:Dictionary<String, Any> = Dictionary<String, Any>()
    
    paramData["CNTS_CRTS_KEY"] = key
    paramData["TRAN_NO"] = "BOOK_TAGT_PROC_SVC"
    paramData["ENC_YN"] = "N"
    paramData["REQ_DATA"] = reqData
    
    return sendPost(paramText: dicToJson(dicData: paramData), urlString: url)
}

// MARK: url통신 할 data 세팅(독서경영 대상자 삭제)
func removeBookTarget(date: String, id: String, name: String) -> [String: Any]?{
    
    //roumit bizplay api url
    let url: String = httpUrl
    
    //요청값 세팅
    var reqData: Dictionary<String, Any> = Dictionary<String, Any>()
    reqData["PROC_GB"] = "D"
    reqData["REG_DT"] = date
    reqData["USER_ID"] = id
    reqData["USER_NM"] = name
    
    var paramData:Dictionary<String, Any> = Dictionary<String, Any>()
    
    paramData["CNTS_CRTS_KEY"] = key
    paramData["TRAN_NO"] = "BOOK_TAGT_PROC_SVC"
    paramData["ENC_YN"] = "N"
    paramData["REQ_DATA"] = reqData
    
    return sendPost(paramText: dicToJson(dicData: paramData), urlString: url)
}

// MARK: 독서경영 일자 등록
func addDateBookTarget(date: String) -> [String: Any]?{
    
    //roumit bizplay api url
    let url: String = httpUrl
    
    //요청값 세팅
    var reqData: Dictionary<String, Any> = Dictionary<String, Any>()
    reqData["PROC_GB"] = "I"
    reqData["REG_DT"] = date
    
    var paramData:Dictionary<String, Any> = Dictionary<String, Any>()
    
    paramData["CNTS_CRTS_KEY"] = key
    paramData["TRAN_NO"] = "BOOK_INFO_PROC_SVC"
    paramData["ENC_YN"] = "N"
    paramData["REQ_DATA"] = reqData
    
    return sendPost(paramText: dicToJson(dicData: paramData), urlString: url)
}

// MARK: 전달받은 날짜(yyyyMMdd) 독서경영 대상자 조회
func lookupBookTarget(date: String, id: String) -> [String: Any]?{
    
    //roumit bizplay api url
    let url: String = httpUrl
    
    //요청값 세팅
    var reqData: Dictionary<String, Any> = Dictionary<String, Any>()
    reqData["REG_DT"] = date
    reqData["VOTER_ID"] = id
    
    var paramData:Dictionary<String, Any> = Dictionary<String, Any>()
    
    paramData["CNTS_CRTS_KEY"] = key
    paramData["TRAN_NO"] = "BOOK_TAGT_SRCH_SVC"
    paramData["ENC_YN"] = "N"
    paramData["REQ_DATA"] = reqData
    
    return sendPost(paramText: dicToJson(dicData: paramData), urlString: url)
}

// MARK: 로그인
func signUpBizplay(id: String, pwd: String) -> [String: Any]?{
    
    //roumit bizplay api url
    let url: String = httpUrl
    
    //요청값 세팅
    var reqData: Dictionary<String, Any> = Dictionary<String, Any>()
    reqData["USER_ID"] = id
    reqData["PWD"]     = pwd
    
    var paramData:Dictionary<String, Any> = Dictionary<String, Any>()
    
    paramData["CNTS_CRTS_KEY"] = key
    paramData["TRAN_NO"] = "COMM_LOGN_SVC"
    paramData["ENC_YN"] = "N"
    paramData["REQ_DATA"] = reqData
    
    return sendPost(paramText: dicToJson(dicData: paramData), urlString: url)
}



// MARK: url통신
func sendPost(paramText: String, urlString: String) -> [String: Any]?{
    
    var result: [String: Any]?
    
    // paramText를 데이터 형태로 변환
    let paramData = paramText.data(using: .utf8)
    
    // URL 객체 정의
    let url = URL(string: urlString)
    
    //동시에 작업 할 수 있는 수 제한(동기방식 처리위함)
    let semaphore = DispatchSemaphore(value: 0)
    
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
        
        // 서버로부터 응답된 스트링 표시
        let outputStr = String(data: data!, encoding: String.Encoding.utf8)
        
        let returnData: String = outputStr!
        
        result = jsonStrToDic(jsonStr: returnData)
        
        //공유 자원 접근 제한 끝
        semaphore.signal()
        
    }
    
    // POST 전송
    task.resume()
    
    //공유자원 접근 감소(나 작업할거니까 기다려!!! 라는 뜻)
    semaphore.wait()
    
    return result
}
