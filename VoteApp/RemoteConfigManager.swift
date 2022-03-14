//
//  RemoteConfigManager.swift
//  Rote
//
//  Created by adam on 2022/02/22.
//

import UIKit
import Firebase

class AppConfig {
    var lastestVersion: String?
    var minVersion: String?
}


class RemoteConfigManager: NSObject {

    static let sharedManager = RemoteConfigManager()
    override private init() {}

    public func launching(completionHandler: @escaping (_ conf: AppConfig) -> (), forceUpdate:@escaping (_ need: Bool)->()) {
        let remoteConfig = RemoteConfig.remoteConfig()

        remoteConfig.fetch(withExpirationDuration: TimeInterval(3600)) { (status, error) -> Void in
            if status == .success {
                remoteConfig.activateFetched()

                // 데이터 Fetch
                let appConfig: AppConfig = AppConfig()
                appConfig.lastestVersion = remoteConfig["lastest_version"].stringValue
                appConfig.minVersion = remoteConfig["min_version"].stringValue

                completionHandler(appConfig)

                // 강제업데이트
                let needForcedUpdate:Bool = (self.compareVersion(versionA: ConfigEnv.appVersion(), versionB: appConfig.minVersion) == ComparisonResult.orderedAscending)
                forceUpdate(needForcedUpdate)
                if needForcedUpdate {
                    let alertController = UIAlertController.init(title: "업데이트", message: "필수 업데이트가 있습니다. 업데이트하시겠습니까?", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction.init(title: "업데이트", style: UIAlertActionStyle.default, handler: { (action) in
                        // 앱스토어마켓으로 이동
                    }))
                    var topController = UIApplication.shared.keyWindow?.rootViewController
                    if topController != nil {
                        while let presentedViewController = topController?.presentedViewController {
                            topController = presentedViewController
                        }
                    }
                    topController!.present(alertController, animated: false, completion: {

                    })
                }

                // 선택업데이트
                let needUpdate:Bool = (self.compareVersion(versionA: ConfigEnv.appVersion(), versionB: appConfig.minVersion) != ComparisonResult.orderedAscending) && (self.compareVersion(versionA: ConfigEnv.appVersion(), versionB: appConfig.lastestVersion) == ComparisonResult.orderedAscending)
                if needUpdate {
                    let alertController = UIAlertController.init(title: "업데이트", message: "최신 업데이트가 있습니다. 업데이트하시겠습니까?", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction.init(title: "업데이트", style: UIAlertActionStyle.default, handler: { (action) in
                        // 앱스토어마켓으로 이동
                    }))
                    alertController.addAction(UIAlertAction.init(title: "나중에", style: UIAlertActionStyle.default, handler: { (action) in
                        // 앱으로 진입
                    }))
                    var topController = UIApplication.shared.keyWindow?.rootViewController
                    if topController != nil {
                        while let presentedViewController = topController?.presentedViewController {
                            topController = presentedViewController
                        }
                    }
                    topController!.present(alertController, animated: false, completion: {

                    })
                }

                }
            }
    }

    private func compareVersion(versionA:String!, versionB:String!) -> ComparisonResult {
        let majorA = Int(Array(versionA.split(separator: "."))[0])!
        let majorB = Int(Array(versionB.split(separator: "."))[0])!

        if majorA > majorB {
            return ComparisonResult.orderedDescending
        } else if majorB > majorA {
            return ComparisonResult.orderedAscending
        }

        let minorA = Int(Array(versionA.split(separator: "."))[1])!
        let minorB = Int(Array(versionB.split(separator: "."))[1])!
        if minorA > minorB {
            return ComparisonResult.orderedDescending
        } else if minorB > minorA {
            return ComparisonResult.orderedAscending
        }
        return ComparisonResult.orderedSame
    }

}
