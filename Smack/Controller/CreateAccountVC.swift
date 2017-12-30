//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Abhishek Goyal on 25/12/17.
//  Copyright © 2017 Abhishek Goyal. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5,0.5,0.5,1]"
    var bgColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activityIndicator.isHidden = true
        let tap = UITapGestureRecognizer(target: self,action: #selector(CreateAccountVC.handleTap))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        
        performSegue(withIdentifier: UNWIND, sender: nil)
        
    }
    
    @IBAction func generateBgPressed(_ sender: Any) {
        
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        self.userImg.backgroundColor = bgColor
        
    }
    @IBAction func chooseAvatarPressed(_ sender: Any) {
        
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
        
    }
    
    @IBAction func createBtnPressed(_ sender: Any) {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        guard let name = usernameTxt.text, usernameTxt.text != "" else { return }
        guard let email = emailTxt.text , emailTxt.text != "" else { return }
        guard let pass = passTxt.text , passTxt.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, pass: pass) { (success) in
            if success {
                print("registered User")
                AuthService.instance.loginUser(email: email, pass: pass, completion: { (success) in
                    if success {
                        print("User Logged In",AuthService.instance.authToken)
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            
                            if success {
                                self.activityIndicator.isHidden = true
                                self.activityIndicator.stopAnimating()
                                print("User added")
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGE, object: nil)
                            }
                            
                        })
                    }
                })
            }
        }
        
    }
    
    
    
}
