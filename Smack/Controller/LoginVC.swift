//
//  LoginVC.swift
//  Smack
//
//  Created by Abhishek Goyal on 24/12/17.
//  Copyright © 2017 Abhishek Goyal. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        spinner.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var closeBtnPressed: UIButton!
    @IBAction func closeBtnPressed(_ sender: Any) {
    
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var loginBtn: RoundedButton!
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let email = userName.text, userName.text != "" else { return }
        guard let pass = passTxt.text, passTxt.text != "" else { return }
        
        AuthService.instance.loginUser(email: email, pass: pass) { (success) in
            
            if success {
                
                AuthService.instance.findUserByEmail(completion: { (success) in
                    
                    if success {
                        
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                    
                })
                
            }
            
        }
        
        
    }
    
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
