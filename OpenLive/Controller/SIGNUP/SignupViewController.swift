//
//  SignupViewController.swift
//  Saathi
//
//  Created by iGridiMac on 19/12/19.
//  Copyright © 2019 iGridiMac. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var username_txt: DesignableUITextField!
    @IBOutlet weak var email_txt: DesignableUITextField!
    @IBOutlet weak var mobileno_txt: DesignableUITextField!
    @IBOutlet weak var password_txt: DesignableUITextField!
    @IBOutlet weak var confirmpswd_txt: DesignableUITextField!
    
    @IBOutlet weak var SignUp: UIButton!

      var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func Signup_act(_ sender: Any) {
    }
    
}


