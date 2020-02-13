//
//  AuthService.swift
//  smack-slack-clone
//
//  Created by Dwi Randy Herdinanto on 13/02/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import Foundation
import Alamofire

class AuthService {
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.string(forKey: TOKEN_KEY)!
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.string(forKey: USER_EMAIL)!
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String:Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString{(response) in
            
            if (response.result.error == nil){
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler){
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String:Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON{ (response) in
            
            if response.result.error == nil {
                
                if let json = response.result.value as? Dictionary<String, Any> {
                    
                    if let userEmail = json["email"] as? String {
                        self.userEmail = userEmail
                    }
                    
                    if let token = json["token"] as? String {
                        self.authToken = token
                    }
                 
                    self.isLoggedIn = true
                    completion(true)
                }
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
