//
//  AuthService.swift
//  GitProject
//
//  Created by Ziyad almohisen on 04/04/2019.
//  Copyright © 2019 Ziyad almohisen. All rights reserved.
//

import Foundation
import  Alamofire
import SwiftyJSON

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
    


func registerUser(email: String, password:String, completion: @escaping completionHandler) {
    
    let lowerCaseEmail = email.lowercased()
    
   
    
    
    let body: [String: Any] = [
        "email": lowerCaseEmail,
        "password": password
    ]
    
    Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
        
        if response.result.error == nil {
            completion(true)
        } else {
            completion(false)
            debugPrint(response.result.error as Any)
        }
    }
    
}

    
    func loginUser(email: String, password: String, completion: @escaping completionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
              
                guard let data = response.data else { return }
                let json = try!JSON(data: data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
            
                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
        
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, comletion: @escaping completionHandler ) {
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
            
        ]
        
        
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
               self.setUserInfo(data: data)
                comletion(true)
                
                
            } else {
                comletion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
   
    func findUserByEmail(completion: @escaping completionHandler) {
        
        Alamofire.request("\(URL_USER_BYEMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                completion(true)
                
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    func setUserInfo(data: Data) {
        let json = try! JSON(data: data)
        let id = json["_id"].stringValue
        let color = json["avatarColor"].stringValue
        let avatarName = json["avatarName"].stringValue
        let email = json["email"].stringValue
        let name = json["name"].stringValue
        
        UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
    
    
        }


        
    }
    
