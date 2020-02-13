//
//  CreateAccountViewController.swift
//  smack-slack-clone
//
//  Created by Dwi Randy Herdinanto on 11/02/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    //Outlets
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let email = emailText.text, emailText.text != "" else { return }
        guard let password = passwordText.text, passwordText.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: password){ (isSuccess) in
            if isSuccess {
                AuthService.instance.loginUser(email: email, password: password){
                    (isSuccess) in
                    if isSuccess {
                        print("Logged in user!", AuthService.instance.authToken)
                    }
                }
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
    }

    @IBAction func pickBgColorPressed(_ sender: Any) {
    }
    
}
