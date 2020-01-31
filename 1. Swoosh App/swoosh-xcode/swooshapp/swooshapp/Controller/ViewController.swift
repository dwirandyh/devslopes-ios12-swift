//
//  ViewController.swift
//  swooshapp
//
//  Created by Dwi Randy Herdinanto on 31/01/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func NavigateToLeague(_ sender: Any) {
        performSegue(withIdentifier: LeaguaViewController.SEGUE_IDENTIFIER, sender: self)
    }
    
}

