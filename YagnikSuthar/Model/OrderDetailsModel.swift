//
//  OrderDetailsModel.swift
//  RegentPayV2
//
//  Created by Govind on 20/04/18.
//  Copyright © 2018 Bhavesh. All rights reserved.
//

import UIKit

class OrderDetailsModel {

/*{
    "status" : "success",
    "message" : {
        "Facilities" : {
            "id" : "9",
            "name" : "Benton County Jail"
        },
        "Orders" : {
            "amount" : "8.00",
            "id" : "542554",
            "user_id" : "5",
            "created_at" : "2018-04-17 02:35:43"
        },
        "OrderProducts" : {
            "product_id" : "1",
            "ppc_phone" : "3182321600",
            "product_name" : "PPC",
            "price" : "5.00",
            "fee_amount" : "3.00"
        },
        "Inmates" : {
            "id" : "",
            "first_name" : "",
            "last_name" : ""
        }
    }
}*/
    
    let FACILITIES_ID           = "id"
    let FACILITIES_NAME         = "name"
    
    let ORDERS_AMOUNT           = "amount"
    let ORDERS_ID               = "order_id" // id
    let ORDERS_USER_ID          = "user_id"
    let ORDERS_CREATED_DT       = "created_at"
    
    let ORDER_PRODUCT_ID        = "product_id"
    let ORDER_PRODUCT_PPC_PN    = "ppc_phone"
    let ORDER_PRODUCT_NAME      = "product_name"
    let ORDER_PRODUCT_PRICE     = "price"
    let ORDER_PRODUCT_FEE_AMT   = "fee_amount"
    
    let INMATE_ID               = "inmate_id" //id 
    let INMATE_FNAME            = "first_name"
    let INMATE_LNAME            = "last_name"
    
    var facilityId       : String = ""
    var facilityName     : String = ""
    
    var ordersAmt        : String = ""
    var ordersId         : String = ""
    var ordersUserId     : String = ""
    var ordersCreatedDt  : String = ""
    
    var orderProductID     : String = ""
    var orderProductPn     : String = ""
    var orderProductName   : String = ""
    var orderProductPrice  : String = ""
    var orderProductFeeAmt : String = ""
    
    var inmateId          : String = ""
    var inmateFname       : String = ""
    var inmateLname       : String = ""
    
    init?(dictionary:[String : Any?]) {
        
        if let tempFacilityID = dictionary[FACILITIES_ID] as? String, tempFacilityID.length > 0 {
            facilityId = tempFacilityID
        }
        
        if let tempFacilityName = dictionary[FACILITIES_NAME] as? String, tempFacilityName.length > 0 {
            facilityName = tempFacilityName
        }
        
        if let tempOrdersAmt = dictionary[ORDERS_AMOUNT] as? String, tempOrdersAmt.length > 0 {
            ordersAmt = tempOrdersAmt
        }
        
        if let tempOrdersID = dictionary[ORDERS_ID] as? String, tempOrdersID.length > 0 {
            ordersId = tempOrdersID
        }
        
        if let temOrdersUserID = dictionary[ORDERS_USER_ID] as? String, temOrdersUserID.length > 0 {
            ordersUserId = temOrdersUserID
        }
        
        if let tempCreatedDate = dictionary[ORDERS_CREATED_DT] as? String, tempCreatedDate.length > 0 {
            ordersCreatedDt = tempCreatedDate
        }
        
        if let tempProdID = dictionary[ORDER_PRODUCT_ID] as? String, tempProdID.length > 0 {
            orderProductID = tempProdID
        }
        
        if let tempProdName = dictionary[ORDER_PRODUCT_NAME] as? String, tempProdName.length > 0 {
            orderProductName = tempProdName
        }
        
        if let tempProdPrice = dictionary[ORDER_PRODUCT_PRICE] as? String, tempProdPrice.length > 0 {
            orderProductPrice = tempProdPrice
        }
        
        if let tempProdFeeAmt = dictionary[ORDER_PRODUCT_FEE_AMT] as? String, tempProdFeeAmt.length > 0 {
            orderProductFeeAmt = tempProdFeeAmt
        }
        
        if let tempProdPhone = dictionary[ORDER_PRODUCT_PPC_PN] as? String, tempProdPhone.length > 0 {
            orderProductPn = tempProdPhone
        }
        
        if let tempInmateID = dictionary[INMATE_ID] as? String {
            inmateId = tempInmateID
        }
        
        if let tempInmateFname = dictionary[INMATE_FNAME] as? String {
            inmateFname = tempInmateFname
        }
        
        if let tempInmateLname = dictionary[INMATE_LNAME] as? String {
            inmateLname = tempInmateLname
        }
    }
    
}
