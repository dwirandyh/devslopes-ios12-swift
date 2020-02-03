//
//  CurrencyTextField.swift
//  windowshopperapp
//
//  Created by Dwi Randy Herdinanto on 31/01/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

@IBDesignable
class CurrencyTextField: UITextField {
    
    override func draw(_ rect: CGRect) {
        drawCurrencyIcon()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }
    
    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    
    func customizeView(){
        backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.4744488442)
        
        layer.cornerRadius = 5.0
        textAlignment = .center
        
        if let place = placeholder {
            let place = NSAttributedString(string: place, attributes: [.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
            attributedPlaceholder = place
        }
        
        textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func drawCurrencyIcon(){
        // Membuat label
        let size: CGFloat = 20
        let currencyLabel = UILabel(frame: CGRect(x: 5, y: (frame.size.height / 2) - size / 2, width: size, height: size))
        currencyLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6701626712)
        currencyLabel.textAlignment = .center
        currencyLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        currencyLabel.layer.cornerRadius = 5.0
        currencyLabel.clipsToBounds = true
        
        // mendapatkan currency berdasarkan locale di hp misalkan Rp, $
        let formater = NumberFormatter()
        formater.numberStyle = .currency
        formater.locale = .current
        currencyLabel.text = formater.currencySymbol
        
        // menambahkan label ke dalam TextField yang posisinya berdasarkan CGRect UILabelnya
        addSubview(currencyLabel)
    }
}
