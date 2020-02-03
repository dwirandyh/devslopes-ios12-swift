//
//  Category.swift
//  codeswagapp
//
//  Created by Dwi Randy Herdinanto on 01/02/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import Foundation

struct Category{
    private(set) public var categoryName: String
    private(set) public var categoryImage : String
    
    init(title: String, imageName: String) {
        self.categoryName = title
        self.categoryImage = imageName
    }
}
