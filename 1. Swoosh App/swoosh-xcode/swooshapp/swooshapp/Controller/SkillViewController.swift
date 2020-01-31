//
//  SkillViewController.swift
//  swooshapp
//
//  Created by Dwi Randy Herdinanto on 31/01/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class SkillViewController: UIViewController {

    public static let SEGUE_IDENTIFIER = "segueSkill"
    
    var player: Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(player.desiredLeague ?? "")
    }
    @IBAction func selectBeginnerSkill(_ sender: Any) {
        self.player.selectedSkillLevel = "Beginner"
    }
    
    
    @IBAction func selectBallerSKill(_ sender: Any) {
        self.player.selectedSkillLevel = "Baller"
    }
}
