//
//  AuthService.swift
//  Smack
//
//  Created by Abhishek Goyal on 28/12/17.
//  Copyright © 2017 Abhishek Goyal. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService{
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool{
        get{
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set{
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String{
        get{
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set{
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String{
        get{
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set{
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String,pass: String,completion: @escaping CompletionHandler){
        
        let lowerCaseEmail = email.lowercased()
        let header = [
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": pass
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            if response.result.error == nil{
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    func loginUser(email: String,pass: String,completion: @escaping CompletionHandler){
        
        let lowerCaseEmail = email.lowercased()
        let header = [
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": pass
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            if response.result.error == nil{
                
                
                
                
                guard let data = response.data else { return }
                do {
                    let json = try JSON(data: data)
                    print(json)
                    self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                    self.isLoggedIn = true
                    completion(true)
                } catch _ as NSError {
                    
                    print("Login Error")
                    completion(false)
                    
                }
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
        
    }
    
    func createUser(name: String,email: String,avatarName: String,avatarColor: String,completion: @escaping CompletionHandler){
        
        let lowerCaseEmail = email.lowercased()
        let header = [
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer \(AuthService.instance.authToken)"
        ]
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "name": name,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        Alamofire.request(URL_ADD_USER, method: .post, parameters: body, encoding:
            JSONEncoding.default, headers: header).responseJSON { (response) in
            
                if response.result.error == nil {
                    guard let data = response.data else { return }
                    do {
                        let json = try JSON(data: data)
                        let id = json["_id"].stringValue
                        let color = json["avatarColor"].stringValue
                        let name = json["name"].stringValue
                        let avatarName = json["avatarName"].stringValue
                        let email = json["email"].stringValue
                        UserDataService.instance.setUserData(id: id, avatarColor: color, avatarName: avatarName, email: email, name: name)
                        completion(true)
                    } catch _ as NSError {
                        print("Login Error")
                        completion(false)
                    }
                }else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
                
        }
        
    
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler){
        let header = [
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer \(AuthService.instance.authToken)"
        ]
        
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                do {
                    let json = try JSON(data: data)
                    let id = json["_id"].stringValue
                    let color = json["avatarColor"].stringValue
                    let name = json["name"].stringValue
                    let avatarName = json["avatarName"].stringValue
                    let email = json["email"].stringValue
                    UserDataService.instance.setUserData(id: id, avatarColor: color, avatarName: avatarName, email: email, name: name)
                    completion(true)
                } catch _ as NSError {
                    print("Login Error")
                    completion(false)
                }
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
        
    }
    
}
