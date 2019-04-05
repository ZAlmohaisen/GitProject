//
//  UserDataService.swift
//  GitProject
//
//  Created by Ziyad almohisen on 05/04/2019.
//  Copyright © 2019 Ziyad almohisen. All rights reserved.
//

import Foundation

class UserDataService {
    static let instance = UserDataService()
    
      public private(set) var id = ""
      public private(set) var avatarColor = ""
      public private(set) var avatarName = ""
      public private(set) var email = ""
      public private(set) var name = ""
    
    func setUserData(id: String, Color: String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarColor = Color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName (avatarName: String) {
        self.avatarName = avatarName
    }
    
}

