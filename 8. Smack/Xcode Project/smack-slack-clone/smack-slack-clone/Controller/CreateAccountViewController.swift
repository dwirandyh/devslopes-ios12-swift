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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //Variables
    var avatarName : String = "profileDefault"
    var avatarColor : String = "[0.5, 0.5, 0.5, 1]"
    var backgroundColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            self.userImage.image = UIImage(named: UserDataService.instance.avatarName)
            self.avatarName = UserDataService.instance.avatarName
            
            if self.avatarName.contains("light") && backgroundColor == nil {
                self.userImage.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        spinner.isHidden = true
        spinner.startAnimating()
        
        guard let name = usernameText.text, usernameText.text != "" else { return }
        guard let email = emailText.text, emailText.text != "" else { return }
        guard let password = passwordText.text, passwordText.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: password){ (isSuccess) in
            if isSuccess {
                AuthService.instance.loginUser(email: email, password: password){
                    (isSuccess) in
                    if isSuccess {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor) { (isSuccess) in
                            self.spinner.isHidden = true
                            self.spinner.stopAnimating()
                            if isSuccess {
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
                                
                                // Send notification
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func pickBgColorPressed(_ sender: Any) {
        let red : CGFloat = CGFloat(arc4random_uniform(255)) / 255
        let green : CGFloat = CGFloat(arc4random_uniform(255)) / 255
        let blue : CGFloat = CGFloat(arc4random_uniform(255)) / 255
        
        backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        UIView.animate(withDuration: 0.2) {
            self.userImage.backgroundColor = self.backgroundColor
        }
    }
    
    func setupView(){
        spinner.isHidden = true
        usernameText.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor: SMACK_PURPLE_COLOR])
        emailText.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor : SMACK_PURPLE_COLOR])
        passwordText.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : SMACK_PURPLE_COLOR])
        
        // hide keyboard when tap outside keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountViewController.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
}
