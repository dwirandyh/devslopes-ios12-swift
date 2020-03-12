//
//  DownloadService.swift
//  github_topic_app
//
//  Created by Dwi Randy Herdinanto on 04/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class DownloadService {
    static let instance = DownloadService()
    
    private func downloadTrendingReposDictArray(completion: @escaping (_ reposDictArray: [Dictionary<String,Any>]) -> ()){
        
        var trendingReposArray = [Dictionary<String, Any>]()
        
        Alamofire.request(trendingRepoUrl).responseJSON { (response) in
            guard let json = response.result.value as? Dictionary<String, Any> else { return }
            guard let repoDictionaryArray = json["items"] as? [Dictionary<String, Any>] else { return }
            for repo in repoDictionaryArray {
                if trendingReposArray.count <= 10 {
                    guard  let name = repo["name"] as? String,
                        let description = repo["description"] as? String,
                        let numberOfForks = repo["forks_count"] as? Int,
                        let repoUrl = repo["html_url"] as? String,
                        let contributorUrl = repo["contributors_url"] as? String,
                        let ownerDict = repo["owner"] as? Dictionary<String, Any>,
                        let avatarUrl = ownerDict["avatar_url"] as? String
                        else { return }
                    
                    let repoDictionary : Dictionary<String, Any> = [
                        "name" : name,
                        "description": description,
                        "forks_count": numberOfForks,
                        "language": "",
                        "html_url": repoUrl,
                        "contributors_url": contributorUrl,
                        "avatar_url": avatarUrl
                    ]
                    
                    trendingReposArray.append(repoDictionary )
                } else {
                    break;
                }
            }
            
            completion(trendingReposArray)
        }
    }
    
    func downloadTrendingRepo(completion: @escaping (_ reposArray: [Repo]) -> ()){
        self.downloadTrendingReposDictArray { (repoDictionary) in
            var trendingRepos : [Repo] = [Repo]()
            for dict in repoDictionary {
                self.mapToRepo(fromDictionary: dict) { (repo) in
                    if trendingRepos.count < 9 {
                        trendingRepos.append(repo)
                    } else {
                        let sortedRepos = trendingRepos.sorted { (repo1, repo2) -> Bool in
                            if repo1.numberOfForks > repo2.numberOfForks {
                                return true
                            } else {
                                return false
                            }
                        }
                        completion(sortedRepos)
                    }
                }
            }
        }
    }
    
    private func mapToRepo(fromDictionary dict: Dictionary<String, Any>, completion: @escaping (_ repo: Repo) -> Void){
        let avatarUrl = dict["avatar_url"] as! String
        let contributorsUrl = dict["contributors_url"] as! String
        let name = dict["name"] as! String
        let description = dict["description"] as! String
        let numberOfForks = dict["forks_count"] as! Int
        let language = dict["language"] as! String
        let repoUrl = dict["html_url"] as! String
        
//        let avatarUrl = "https://www.freeiconspng.com/uploads/no-image-icon-10.png"
    
        
        self.downloadImageFor(avatarUrl: avatarUrl) { (avatarImage) in
            self.downloadContributorsDataFor(contributorsUrl: contributorsUrl) { (returnedContributors) in
                let repo = Repo(image: avatarImage, name: name, description: description, numberOfForks: numberOfForks, language: language, numberOfContributors: returnedContributors, repoUrl: repoUrl)
                completion(repo)
            }
        }
    }
    
    func downloadImageFor(avatarUrl: String, completion: @escaping (_ image: UIImage) -> ()) {
        Alamofire.request(avatarUrl).responseImage { (imageResponse) in
            guard let image = imageResponse.result.value else { return}
            completion(image)
        }
    }
    
    func downloadContributorsDataFor(contributorsUrl: String, completion: @escaping (_ contributors: Int) -> ()){
        Alamofire.request(contributorsUrl).responseJSON { (response) in
            guard let json = response.result.value as? [Dictionary<String, Any>] else { return }
            if !json.isEmpty {
                let contributors = json.count
                completion(contributors)
            }
        }
    }
}
