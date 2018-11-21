//
//  Constant.swift
//  linphone-swift-demo
//
//  Created by Bhavesh on 13/03/18.
//  Copyright © 2018 WiAdvance. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Screen Constants

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MIN_LENGTH = min(SCREEN_WIDTH, SCREEN_HEIGHT)

let IS_IPHONE = UIDevice.current.userInterfaceIdiom == .phone
let IS_IPHONE_4_OR_LESS =  UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH < 568.0
let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 568.0
let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 667.0
let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 736.0
let IS_IPHONE_10 = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 812.0
let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad

// MARK: - Common Used
let APP_NAME             = "Practical YagnikSuthar"

let MAX_LENGTH_ADDRESS    = 100
let MAX_LENGTH_PINCODE    = 6
let MAX_LENGTH_PASS       = 50
let NUMBERS               = "0123456789"

let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
let ACCEPTABLE_CHARACTERS_WITHSPACE = " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'"
let ACCEPTABLE_CHARACTERS_PINCODE = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 "

let appDelegate = UIApplication.shared.delegate as? AppDelegate

enum USER_STATE : Int {
    case NOT_LOGGED_IN = 0
    case LOGGED_IN     = 1
}

// MARK: - All URL Here

// Developer URL
let MAIN_URL = "web"

let GET_ORDER_DETAILS_URL                  = MAIN_URL + "abc"
