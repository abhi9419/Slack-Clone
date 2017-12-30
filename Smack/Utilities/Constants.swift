//
//  Constants.swift
//  Smack
//
//  Created by Abhishek Goyal on 24/12/17.
//  Copyright © 2017 Abhishek Goyal. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

let LOGGED_IN_KEY = "loggedIn"
let TOKEN_KEY = "token"
let USER_EMAIL = "userEmail"

//urls
let BASE_URL = "http://localhost:3005/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_ADD_USER = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNEL = "\(BASE_URL)channel/"

let NOTIF_USER_DATA_CHANGE = Notification.Name("notifUserDataChanged")
