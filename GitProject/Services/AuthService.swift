//
//  AuthService.swift
//  GitProject
//
//  Created by Ziyad almohisen on 04/04/2019.
//  Copyright © 2019 Ziyad almohisen. All rights reserved.
//

import Foundation
import  Alamofire

class AuthService {
    
    static let instance = AuthService()
    
    let defualts = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defualts.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defualts.set(newValue, forKey: LOGGED_IN_KEY)
        }
        
    }
    
    var authToken : String {
        get {
            return defualts.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defualts.set(newValue, forKey: TOKEN_KEY)
        }
        
    }
    
    var userEmail: String {
        get {
            return defualts.value(forKey: USER_EMAIL) as! String
        }
        set {
            defualts.set(newValue, forKey: USER_EMAIL)
        }
    }
    
}

func registerUser(email: String, password:String, completion: @escaping completionHandler) {
    
    let lowerCaseEmail = email.lowercased()
    
    let header = [
        "Content-Type": "application/json; charset=utf-8"
    ]
    
    
    let body: [String: Any] = [
        "email": lowerCaseEmail,
        "password": password
    ]
    
    Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
        
        if response.result.error == nil {
            completion(true)
        } else {
            completion(false)
            debugPrint(response.result.error as Any)
        }
    }
    
}
