//
//  ChannelVC.swift
//  Smack
//
//  Created by Abhishek Goyal on 18/12/17.
//  Copyright © 2017 Abhishek Goyal. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var loginBtnOutlet: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_CHANGE, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    
    func setupUserInfo(){
        if AuthService.instance.isLoggedIn {
            loginBtnOutlet.setTitle(UserDataService.instance.name, for: .normal)
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
        }else{
            loginBtnOutlet.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
        }
    }
    
    @objc func userDataDidChange(_ notif: Notification){
        
        setupUserInfo()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
                //Show Profile
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        }else{
                performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
        
        
        
    }
    

}
