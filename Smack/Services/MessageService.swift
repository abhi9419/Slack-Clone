//
//  MessageService.swift
//  Smack
//
//  Created by Abhishek Goyal on 30/12/17.
//  Copyright © 2017 Abhishek Goyal. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService{
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    
    
    func findAddAllChannel(completion: @escaping CompletionHandler){
        
        let header = [
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer \(AuthService.instance.authToken)"
        ]
        
        Alamofire.request(URL_GET_CHANNEL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            if response.result.error == nil {
                
                guard let data = response.data else { return }
                do {
                    if let json = try JSON(data: data).array{
                        
                        for item in json {
                            
                            print(item)
                            let name = item["name"].stringValue
                            let desc = item["description"].stringValue
                            let id = item["_id"].stringValue
                            let channel = Channel(channelTitle: name, channelDesc: desc, id: id)
                            self.channels.append(channel)
                            completion(true)
                            
                        }
                        
                    }
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
