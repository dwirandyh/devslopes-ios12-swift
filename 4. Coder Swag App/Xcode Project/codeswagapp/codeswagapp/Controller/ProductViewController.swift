//
//  ProductViewController.swift
//  codeswagapp
//
//  Created by Dwi Randy Herdinanto on 03/02/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var productsCollection : UICollectionView!
    
    private(set) public var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.productsCollection.dataSource = self
        self.productsCollection.delegate = self
    }
    
    func initProducts(category: Category){
        self.products = DataService.instance.getProducts(forCategoryTitle: category.categoryName)
        
        navigationItem.title = category.categoryName
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell {
            let product = self.products[indexPath.row]
            cell.updateViews(product: product)
            return cell
        }
        return ProductCell()
    }

}
