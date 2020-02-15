//
//  AddChannelViewController.swift
//  smack-slack-clone
//
//  Created by Dwi Randy Herdinanto on 15/02/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class AddChannelViewController: UIViewController {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var backgroundView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    @IBAction func createChannelPressed(_ sender: Any) {
        
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupView(){
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelViewController.closeTap(_:)))
        backgroundView.addGestureRecognizer(closeTouch)
        
//        nameText.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor: SMACK_PURPLE_COLOR])
//        descriptionText.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedString.Key.foregroundColor: SMACK_PURPLE_COLOR])
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
}
