//
//  AvatarPickerViewController.swift
//  smack-slack-clone
//
//  Created by Dwi Randy Herdinanto on 14/02/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class AvatarPickerViewController: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var avatarType : AvatarType = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentControlChanged(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0 {
            self.avatarType = .dark
        }else {
            self.avatarType = .light
        }
        
        self.collectionView.reloadData()
    }
}

extension AvatarPickerViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
            cell.configureCell(index: indexPath.item, type: self.avatarType)
            return cell
        }
        return AvatarCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numOfColumns : CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numOfColumns = 4
        }
        
        let spaceBetweenCells : CGFloat = 10
        let padding : CGFloat = 40
        let cellDimension = ((collectionView.bounds.width - padding) - (numOfColumns - 1) * spaceBetweenCells) / numOfColumns
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.avatarType == AvatarType.dark {
            UserDataService.instance.setAvatarName(name: "dark\(indexPath.item)")
        }else {
            UserDataService.instance.setAvatarName(name: "light\(indexPath.item)")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
}

extension AvatarPickerViewController : UICollectionViewDelegate {
    
    
}

extension AvatarPickerViewController : UICollectionViewDelegateFlowLayout {
    
}
