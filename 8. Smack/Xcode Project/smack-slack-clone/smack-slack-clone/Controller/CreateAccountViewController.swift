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
    
    //Variables
    var avatarName : String = "profileDefault"
    var avatarColor : String = "[0.5, 0.5, 0.5, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let name = usernameText.text, usernameText.text != "" else { return }
        guard let email = emailText.text, emailText.text != "" else { return }
        guard let password = passwordText.text, passwordText.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: password){ (isSuccess) in
            if isSuccess {
                AuthService.instance.loginUser(email: email, password: password){
                    (isSuccess) in
                    if isSuccess {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor) { (isSuccess) in
                            if isSuccess {
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
                            }
                        }
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
