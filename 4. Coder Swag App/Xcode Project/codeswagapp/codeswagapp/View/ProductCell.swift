//
//  ProductViewCell.swift
//  codeswagapp
//
//  Created by Dwi Randy Herdinanto on 03/02/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet weak var productImage : UIImageView!
    @IBOutlet weak var productTitle : UILabel!
    @IBOutlet weak var productPrice : UILabel!
    
    func updateViews(product: Product){
        productImage.image = UIImage(named: product.imageName)
        productTitle.text = product.title
        productPrice.text = product.price
    }
}
