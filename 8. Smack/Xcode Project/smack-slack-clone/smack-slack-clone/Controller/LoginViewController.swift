//
//  LoginViewController.swift
//  smack-slack-clone
//
//  Created by Dwi Randy Herdinanto on 11/02/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    
    @IBAction func loginPressed(_ sender: Any) {
        
    }
}
