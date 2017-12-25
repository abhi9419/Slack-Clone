//
//  ChannelVC.swift
//  Smack
//
//  Created by Abhishek Goyal on 18/12/17.
//  Copyright © 2017 Abhishek Goyal. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var loginBtnOutlet: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
        
    }
    

}
