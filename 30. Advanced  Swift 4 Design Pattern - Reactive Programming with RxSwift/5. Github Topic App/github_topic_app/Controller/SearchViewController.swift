//
//  SearchViewController.swift
//  github_topic_app
//
//  Created by Dwi Randy Herdinanto on 01/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: RoundedBorderTextField!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.bindElements()
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
    }
    
    func bindElements(){
        let searchResultObservable = searchTextField.rx.text
            .orEmpty
            .throttle(0.5, latest: true, scheduler: MainScheduler.instance)
            .map{
                $0.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }.flatMap { (query) -> Observable<[Repo]> in
            if query == "" {
                return Observable<[Repo]>.just([])
            } else {
                let url = searchUrl + query + starsDescendingSegment
                var searchRepos = [Repo]()
                
                return URLSession.shared.rx.json(url: URL(string: url)!).map {
                    let result = $0 as AnyObject
                    let items = result.object(forKey: "items") as? [Dictionary<String, Any>] ?? []
                    
                    for item in items {
                        guard let name = item["name"] as? String,
                            let description = item["description"] as? String,
                            let language = item["language"] as? String,
                            let forksCount = item["forks_count"] as? Int,
                            let repoUrl = item["html_url"] as? String else { break }
                        
                        let repo = Repo(image: UIImage(named: "searchIconLarge")!, name: name, description: description, numberOfForks: forksCount, language: language, numberOfContributors: 0, repoUrl: repoUrl)
                        
                        searchRepos.append(repo)
                    }
                    return searchRepos
                }
            }
        }
        .observeOn(MainScheduler.instance)
        
        searchResultObservable.catchErrorJustReturn([]).bind(to: self.tableView.rx.items(cellIdentifier: "searchCell")){ (row, repo: Repo, cell: SearchCell) in
            cell.configureCell(repo: repo)
        }.disposed(by: self.disposeBag)
    }
}

extension SearchViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SearchCell else { return }
        guard let url = cell.repoUrl else { return }
        self.presentSFSafariVCFor(url: url)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

extension SearchViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
