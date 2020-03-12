//
//  SearchCell.swift
//  github_topic_app
//
//  Created by Dwi Randy Herdinanto on 11/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    var repoUrl: String?
    
    func configureCell(repo: Repo){
        repoNameLabel.text = repo.name
        repoDescriptionLabel.text = repo.description
        forksCountLabel.text = String(repo.numberOfForks)
        languageLabel.text = repo.language
        
        repoUrl = repo.repoUrl
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 15
    }
}
