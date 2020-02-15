//
//  ProfileViewController.swift
//  smack-slack-clone
//
//  Created by Dwi Randy Herdinanto on 15/02/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func closeModalPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func setupView(){
        emailLabel.text = UserDataService.instance.email
        nameLabel.text = UserDataService.instance.name
        userImage.image = UIImage(named: UserDataService.instance.avatarName)
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.closeTab(_:)))
        self.backgroundView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTab(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
}
