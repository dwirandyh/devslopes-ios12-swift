//
//  RoundedButton.swift
//  smack-slack-clone
//
//  Created by Dwi Randy Herdinanto on 13/02/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable
    var cornerRadius : CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = cornerRadius
        self.frame.size = CGSize(width: self.frame.size.width, height: 40)
    }
}
