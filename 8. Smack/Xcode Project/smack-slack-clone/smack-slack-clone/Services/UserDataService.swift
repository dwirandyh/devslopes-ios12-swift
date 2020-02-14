//
//  UserDataService.swift
//  smack-slack-clone
//
//  Created by Dwi Randy Herdinanto on 14/02/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    public private(set) var id : String = ""
    public private(set) var avatarColor : String = ""
    public private(set) var avatarName : String = ""
    public private(set) var email : String = ""
    public private(set) var name : String = ""
    
    func setUserData(id: String, avatarColor: String, avatarName: String, email: String, name: String){
        self.id = id
        self.avatarColor = avatarColor
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
}
