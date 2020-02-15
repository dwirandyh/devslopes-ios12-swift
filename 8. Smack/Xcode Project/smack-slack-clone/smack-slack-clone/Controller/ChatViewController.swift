//
//  ChatViewController.swift
//  smack-slack-clone
//
//  Created by Dwi Randy Herdinanto on 04/02/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMenuButton()
    }
    
    func initMenuButton(){
        self.menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (isSuccess) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
        
        MessageService.instance.findAllChannel { (isSuccess) in
            if isSuccess {
                
            }
        }
    }
}
