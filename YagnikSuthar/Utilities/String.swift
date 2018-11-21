//
//  StringExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yagnik Suthar on 4/17/18.
//  Copyright © 2018 Bhavesh. All rights reserved.
//

import Foundation

extension String
{
    //Email Validation
    static func isValidEmail(strTest: String) -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-zA-Z0-9-]*[a-zA-Z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: strTest)
    }
    
    //Name Validation
    static func isValidFieldString(strTest: String) -> Bool {
        let nameRegEx = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: strTest)
    }
    
    //Phone Number validation
    static func isValidPhoneNo(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    static func isValidPancardNumber(value: String) -> Bool {
        let PAN_REGEX = "[A-Z]{5}[0-9]{4}[A-Z]{1}"
        let panNumberTest = NSPredicate(format: "SELF MATCHES %@", PAN_REGEX)
        let result =  panNumberTest.evaluate(with: value)
        return result
    }
    
    //Length validation
    static func isValidLength(strCheckForLength: String?) -> Bool {
        if strCheckForLength == nil {
            return false
        }
        if (strCheckForLength?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).length)! >= 1 {
            return true
        }else{
            return false
        }
    }
    
    static func isValidNameLength(strNameLength: String) -> Bool {
        if strNameLength.count < 100 {
            return false
        } else {
            return true
        }
    }
    
    static func isValidMobileNumberLength(strCheckMobileNumberLength: String) -> Bool {
        if strCheckMobileNumberLength.count < 10 {
            return false
        }else {
            return true
        }
    }
    
    static func isValidPinCodeLength(strPincodeLength: String) -> Bool{
        if strPincodeLength.count < 6 {
            return false
        } else {
            return strPincodeLength.length <= MAX_LENGTH_PINCODE
        }
    }
    
    //Password Validation : Check current and confirm is same.
    static func isPwdsSame(password: String , confirmPassword : String) -> Bool {
        if password == confirmPassword {
            return true
        } else {
            return false
        }
    }
    
    //Password length validation : length should grater than 7.
    static func isPwdLenth(password: String , confirmPassword : String, length: Int) -> Bool {
        if password.count <= length && confirmPassword.count <= length {
            return true
        }else {
            return false
        }
    }
    
//    var convertToDate : Date {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd" // Your date format
//        let serverDate: Date = dateFormatter.date(from: self)! // according to date format your date string
//        return serverDate
//    }
}
