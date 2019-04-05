//
//  Constants.swift
//  GitProject
//
//  Created by Ziyad almohisen on 02/04/2019.
//  Copyright © 2019 Ziyad almohisen. All rights reserved.
//

import Foundation

typealias completionHandler = (_ Success: Bool) -> ()

// URL Constant
let BASE_URL = "https://hidden-bastion-48828.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"

// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"

// User defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]
