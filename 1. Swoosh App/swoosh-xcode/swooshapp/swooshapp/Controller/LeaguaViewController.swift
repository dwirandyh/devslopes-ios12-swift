//
//  LeaguaViewController.swift
//  swooshapp
//
//  Created by Dwi Randy Herdinanto on 31/01/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class LeaguaViewController: UIViewController {

    public static let SEGUE_IDENTIFIER = "segueLeague"
    
    var player : Player!
    
    @IBOutlet weak var nextButton: BorderButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.player = Player()
        
        nextButton.isEnabled = false
    }
    
    @IBAction func selectManOption(_ sender: Any) {
        selectLeague(desiredLeague: "Mens")
    }
    
    @IBAction func selectWoman(_ sender: Any) {
        selectLeague(desiredLeague: "Womens")
    }
    
    @IBAction func selectCoed(_ sender: Any) {
        selectLeague(desiredLeague: "Coed")
    }
    
    @IBAction func navigateToSKill(_ sender: Any) {
        performSegue(withIdentifier: SkillViewController.SEGUE_IDENTIFIER, sender: self)
    }
    
    func selectLeague(desiredLeague: String){
        self.player.desiredLeague = desiredLeague
        nextButton.isEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let skillViewController = segue.destination as? SkillViewController {
            skillViewController.player = self.player
        }
    }
    
}
