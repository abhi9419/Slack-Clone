//
//  UserDataService.swift
//  Smack
//
//  Created by Abhishek Goyal on 29/12/17.
//  Copyright © 2017 Abhishek Goyal. All rights reserved.
//

import Foundation

class UserDataService{
    
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String,avatarColor: String,avatarName: String,email: String,name: String){
        self.id = id;
        self.avatarName = avatarName
        self.avatarColor = avatarColor
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String){
        
        self.avatarName = avatarName
        
    }
    
    func logoutUser(){
        
        id = "";
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.authToken = ""
        AuthService.instance.userEmail  = ""
        
    }
    
}
