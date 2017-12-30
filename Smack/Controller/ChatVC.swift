//
//  ChatVC.swift
//  Smack
//
//  Created by Abhishek Goyal on 18/12/17.
//  Copyright © 2017 Abhishek Goyal. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    //Outlets
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        if AuthService.instance.isLoggedIn{
            
            AuthService.instance.findUserByEmail(completion: { (success) in
                
                if success {
                    
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGE, object: nil)
                    
                    
                }
                
            })
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
