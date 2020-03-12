//
//  RoundedBorderButton.swift
//  github_topic_app
//
//  Created by Dwi Randy Herdinanto on 01/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedBorderButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    func setupView(){
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = 3
        layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
}
