//
//  PopVC.swift
//  pixel-city
//
//  Created by Dwi Randy Herdinanto on 08/09/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import UIKit

class PopVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var popImageView: UIImageView!

    var passedImage: UIImage!

    func initData(forImage image: UIImage) {
        self.passedImage = image
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        popImageView.image = self.passedImage

        addDoubleTap()
    }

    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(screenWasDoubleTapped))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        view.addGestureRecognizer(doubleTap)
    }

    @objc func screenWasDoubleTapped() {
        dismiss(animated: true, completion: nil)
    }
}
