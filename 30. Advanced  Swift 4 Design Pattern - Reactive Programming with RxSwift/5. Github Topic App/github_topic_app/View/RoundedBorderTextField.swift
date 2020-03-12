//
//  RoundedBorderTextField.swift
//  github_topic_app
//
//  Created by Dwi Randy Herdinanto on 02/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedBorderTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        
       setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setupView()
    }
    
    func setupView(){
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)])
               attributedPlaceholder = placeholder
               backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
               layer.cornerRadius = frame.height / 2
               layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
               layer.borderWidth = 3
    }
}
