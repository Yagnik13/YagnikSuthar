//
//  CommonManager.swift
//  linphone-swift-demo
//
//  Created by Bhavesh on 13/03/18.
//  Copyright © 2018 WiAdvance. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import ReachabilitySwift
class CommonManager: NSObject {
    
    static let sharedInstance: CommonManager = {
        let instance = CommonManager()
        instance.initialize()
        return instance
    }()
    
    var strDeviceToken      : String? = "3b5966b6555571f88aaa92a1e48a552c"
    var isConnected         : Bool = false
    
    var reachability : Reachability!
    
    func initialize () {
        setUpReachability()
    }
    
    // MARK: - All Comman Functions
    
    func convertUSANumberToString(strConvertString : String) -> String {
        var strConvertNumbr : String?
        strConvertNumbr = strConvertString.replacingOccurrences(of: "(", with: "")
        strConvertNumbr = strConvertNumbr?.replacingOccurrences(of: ")", with: "")
        strConvertNumbr = strConvertNumbr?.replacingOccurrences(of: "-", with: "")
        strConvertNumbr = strConvertNumbr?.replacingOccurrences(of: " ", with: "")
        return (strConvertNumbr)!
    }
    
    func nsStringFromDate(date: NSDate, andToFormatString formatString: String) -> String {
        var formatter: DateFormatter?
        if formatter == nil {
            formatter = DateFormatter()
        }
        formatter?.dateFormat = formatString
        let dateString: String = (formatter?.string(from: date as Date)) ?? ""
        return dateString
    }
    
    // MARK: - Reachability Setup
    
    func setUpReachability () {
        reachability = Reachability.init()!
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(note:)),name: ReachabilityChangedNotification,object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: NSNotification) {
        reachability = note.object as! Reachability
        if reachability.isReachable {
            if reachability.isReachableViaWiFi {
                isConnected = true
                print("Reachable via WiFi")
            } else {
                isConnected = true
                print("Reachable via Cellular")
            }
        } else {
            isConnected = false
            print("Not reachable")
        }
    }
    
    // MARK: - Progress HUD
    
    func showHud() {
        SVProgressHUD.show()
    }
    
    func showHudWithTitle(title : String) {
        SVProgressHUD.show(withStatus: title)
    }
    
    func hideHud() {
        SVProgressHUD.dismiss()
    }
    
    // MARK: - System Version Function
    func getSystemVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    // MARK: - Show Alert
    
    func showAlertWithMessage(message: String, withController viewCtr: UIViewController) {
        let  alertController = UIAlertController(title: APP_NAME, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        viewCtr.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Call For API Here
    
    func callWebService(strUrl : String?, withParameters parameters: [String : Any]?, httpMethod : HTTPMethod?, withSuccessHandler success : (([String : AnyObject]?) -> Void)?, withErrorHandler errorMsg : ((String?) -> Void)?) {
        
        let headers = [ KCONTENT_TYPE : KCONTENT_TYPE_VALUE]
        
        Alamofire.request(strUrl!, method: httpMethod!, parameters: parameters, encoding: JSONEncoding.default, headers : headers).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value as? [String: AnyObject]  {
                    let jsonData = JSON(value)
                    print("JSON: \(jsonData)")
                    if (jsonData["status"].stringValue == "success") {
                        success?(value)
                    } else {
                        if let message = jsonData["message"].string {
                            errorMsg?(message)
                        } else {
                            errorMsg?(V_INVALID_RESPONSE)
                        }
                    }
                }
            case .failure(let error):
                print(error)
                if let data = response.data {
                    print("Response data: \(NSString(data: data, encoding: String.Encoding.utf8.rawValue)!)")
                    if (error as NSError).code != NSURLErrorCancelled {
                        if ((error as NSError).code == -1001 || (error as NSError).code == -1005) {
                            self.callWebService(strUrl: strUrl, withParameters: parameters, httpMethod: httpMethod, withSuccessHandler: { (_) in }, withErrorHandler: { (_) in})
                        } else {
                            errorMsg?(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
}
