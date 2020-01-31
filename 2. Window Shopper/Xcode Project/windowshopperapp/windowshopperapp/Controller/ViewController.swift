//
//  ViewController.swift
//  windowshopperapp
//
//  Created by Dwi Randy Herdinanto on 31/01/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var wageText: CurrencyTextField!
    @IBOutlet weak var priceText: CurrencyTextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateCalculateButton()
        
        resultLabel.isHidden = true
        hoursLabel.isHidden = true
    }
    
    func generateCalculateButton(){
        let calculateButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        calculateButton.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        calculateButton.setTitle("Calculate", for: .normal)
        calculateButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
    
        calculateButton.addTarget(self, action: #selector(ViewController.calculate), for: .touchUpInside)
        
        wageText.inputAccessoryView = calculateButton
        priceText.inputAccessoryView = calculateButton
    }
    
    @objc func calculate(){
        if let wageText = wageText.text, let priceText = priceText.text {
            if let wage = Double(wageText), let price = Double(priceText) {
                view.endEditing(true)
                resultLabel.isHidden = false
                hoursLabel.isHidden = false
                resultLabel.text = "\(Wage.getHours(forWage: wage, andPrice: price))"
            }
        }
    }

    @IBAction func clearCalculation(_ sender: Any) {
        resultLabel.isHidden = true
        hoursLabel.isHidden = true
        wageText.text = ""
        priceText.text = ""
    }
    
}

