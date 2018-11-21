//
//  ViewController.swift
//  YagnikSuthar
//
//  Created by yagnik on 21/11/18.
//  Copyright © 2018 yagnik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
     var aryOrderDetailsList   = [OrderDetailsModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - API Call Here
    
    func getOrderDetails() {
        if (CommonManager.sharedInstance.isConnected) {
            CommonManager.sharedInstance.showHudWithTitle(title: STR_LOADING)
            
            let parameters = [
                "PARM_TOKEN"    : (CommonManager.sharedInstance.strDeviceToken ?? ""),
                "K_PLATFORM"    : "K_PLATFORM_VALUE",
                "K_APP_VERSION" : "K_APP_VERSION_VALUE" ?? "",
                "PARM_ORDER_ID" : "strOrderID"
            ]
            
            print("parameters :- ", parameters)
            print("URL :- ", GET_ORDER_DETAILS_URL)
            
            CommonManager.sharedInstance.callWebService(strUrl: GET_ORDER_DETAILS_URL, withParameters: (parameters as Any as! [String : Any]), httpMethod: .post, withSuccessHandler: { [weak self] (dicResponseWithSuccess) in
                CommonManager.sharedInstance.hideHud()
                
                if let weakSelf = self {
                    if let response = dicResponseWithSuccess {
                        if let ordersHisDic = response["message"] as? [String : Any?] {
                            if var facilitiesDic = ordersHisDic["Facilities"] as? [String : Any?],
                                var ordersDic = ordersHisDic["Orders"] as? [String : Any?],
                                var orderProdDic = ordersHisDic["OrderProducts"] as? [String : Any?],
                                var inmatesDic = ordersHisDic["Inmates"] as? [String : Any?],
                                let ordersAmt = ordersDic["amount"] as? String,
                                let ordersID = ordersDic["id"] as? String,
                                let ordersUserId = ordersDic["user_id"] as? String,
                                let ordersCreatedDt = ordersDic["created_at"] as? String,
                                let orderProdId = orderProdDic["product_id"] as? String,
                                let orderProdPhone = orderProdDic["ppc_phone"] as? String,
                                let orderProdName = orderProdDic["product_name"] as? String,
                                let orderProdPrice = orderProdDic["price"] as? String,
                                let orderProdFeeAmt = orderProdDic["fee_amount"] as? String,
                                let inmatesID = inmatesDic["id"] as? String,
                                let inmatesFname = inmatesDic["first_name"] as? String,
                                let inmatesLname = inmatesDic["last_name"] as? String {
                                
                                facilitiesDic["amount"] = ordersAmt
                                facilitiesDic["order_id"] = ordersID
                                facilitiesDic["user_id"] = ordersUserId
                                facilitiesDic["created_at"] = ordersCreatedDt
                                
                                facilitiesDic["product_id"] = orderProdId
                                facilitiesDic["ppc_phone"] = orderProdPhone
                                facilitiesDic["product_name"] = orderProdName
                                facilitiesDic["price"] = orderProdPrice
                                facilitiesDic["fee_amount"] = orderProdFeeAmt
                                
                                facilitiesDic["inmate_id"] = inmatesID
                                facilitiesDic["first_name"] = inmatesFname
                                facilitiesDic["last_name"] = inmatesLname
                                
                                if let objDic = OrderDetailsModel(dictionary: facilitiesDic) {
                                    weakSelf.aryOrderDetailsList.append(objDic)
                                }
                            }
//                            weakSelf.tblOrderDetails.reloadData()
                        } else {
                            if let weakSelf = self {
                                CommonManager.sharedInstance.showAlertWithMessage(message: V_INVALID_RESPONSE, withController: weakSelf)
                            }
                        }
                    }
                }
                }, withErrorHandler: { (errorMsg) in
                    CommonManager.sharedInstance.hideHud()
                    CommonManager.sharedInstance.showAlertWithMessage(message: errorMsg!, withController: self)
            })
        } else {
            CommonManager.sharedInstance.hideHud()
            CommonManager.sharedInstance.showAlertWithMessage(message: V_NO_INTERNET, withController: self)
        }
    }

}

