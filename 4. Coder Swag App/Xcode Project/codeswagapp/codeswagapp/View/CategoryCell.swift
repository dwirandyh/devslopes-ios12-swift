//
//  CategoryCell.swift
//  codeswagapp
//
//  Created by Dwi Randy Herdinanto on 01/02/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryImage : UIImageView!
    @IBOutlet weak var categoryTitle : UILabel!
    
    func updateViews(category : Category){
        categoryImage.image = UIImage(named: category.categoryImage)
        categoryTitle.text = category.categoryName
    }

}
