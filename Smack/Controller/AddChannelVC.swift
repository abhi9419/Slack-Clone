//
//  AddChannelVC.swift
//  Smack
//
//  Created by Abhishek Goyal on 30/12/17.
//  Copyright © 2017 Abhishek Goyal. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    @IBOutlet weak var descTxt: UITextField!
    @IBOutlet weak var channelTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func closePressed(_ sender: Any) {
    
        dismiss(animated: true, completion: nil)
    
    }

    @IBAction func createBtn(_ sender: Any) {
        
    }
    
}
