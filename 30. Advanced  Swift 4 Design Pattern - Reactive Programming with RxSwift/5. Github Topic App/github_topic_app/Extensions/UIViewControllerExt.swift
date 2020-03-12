//
//  UIViewControllerExt.swift
//  github_topic_app
//
//  Created by Dwi Randy Herdinanto on 11/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    func presentSFSafariVCFor(url: String){
        let readMeUrl = URL(string: url + readmeSegment)
        let safariVC = SFSafariViewController(url: readMeUrl!)
        present(safariVC, animated: true, completion: nil)
    }
}
