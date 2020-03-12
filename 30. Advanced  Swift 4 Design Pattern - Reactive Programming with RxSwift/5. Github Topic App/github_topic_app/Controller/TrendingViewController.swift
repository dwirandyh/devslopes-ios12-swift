//
//  TrendingViewController.swift
//  github_topic_app
//
//  Created by Dwi Randy Herdinanto on 01/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TrendingViewController: UIViewController {
    
    @IBOutlet weak var repositoryTableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    var datasource : PublishSubject<[Repo]> = PublishSubject<[Repo]>()
    var disposeBag : DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.repositoryTableView.refreshControl = self.refreshControl
        refreshControl.tintColor = #colorLiteral(red: 0.210316062, green: 0.4686692953, blue: 0.9325436354, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Hot Github Pages", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.210316062, green: 0.4686692953, blue: 0.9325436354, alpha: 1), NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 16.0)!])
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        
        self.fetchData()
        
        self.repositoryTableView.refreshControl = self.refreshControl
        
        datasource.bind(to: repositoryTableView.rx.items(cellIdentifier: "trendingRepoCell")) { (row, repo: Repo, cell: TrendingRepoCell) in
            cell.configureCell(repo: repo)
        }.disposed(by: self.disposeBag)
    }
    
    @objc func fetchData(){
        DownloadService.instance.downloadTrendingRepo { (trendingRepoArray) in
            self.datasource.onNext(trendingRepoArray)
            self.refreshControl.endRefreshing()
        }
    }
}

// WITHOUT RX COCOA
//extension TrendingViewController : UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trendingRepoCell", for: indexPath) as? TrendingRepoCell else { return UITableViewCell() }
//
//        let repo = Repo(image: UIImage(named: "searchIconLarge")!, name: "SWIFT", description: "Apple Programming Language", numberOfForks: 36, language: "Swift", numberOfContributors: 572, repoUrl: "www.github.com")
//        cell.configureCell(repo: repo)
//        return cell
//    }
//
//
//}
//
//extension TrendingViewController : UITableViewDelegate {
//
//}
