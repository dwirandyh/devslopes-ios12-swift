//
//  ChannelViewController.swift
//  smack-slack-clone
//
//  Created by Dwi Randy Herdinanto on 04/02/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var channelTableView: UITableView!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.channelTableView.delegate = self
        self.channelTableView.dataSource = self
        
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelViewController.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelViewController.channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
        
        SocketService.instance.getChannel { (isSuccess) in
            if isSuccess {
                self.channelTableView.reloadData()
            }
        }
        
        SocketService.instance.getChatMessage { (newMessage) in
            if newMessage.channelId != MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                MessageService.instance.unreadChannels.append(newMessage.channelId)
                self.channelTableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            // Show Profile Page
            let profile = ProfileViewController()
            profile.modalPresentationStyle = .custom
            self.present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    @IBAction func addChannelButtonPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let addChannel = AddChannelViewController()
            addChannel.modalPresentationStyle = .custom
            present(addChannel, animated: true, completion: nil)
        }
    }
    
    @objc func userDataDidChange(_ notification: Notification){
        setupUserInfo()
    }
    
    @objc func channelsLoaded(_ notification: Notification){
        self.channelTableView.reloadData()
    }
    
    func setupUserInfo(){
        if AuthService.instance.isLoggedIn {
            loginButton.setTitle(UserDataService.instance.name, for: .normal)
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            userImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        }else{
            loginButton.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
            self.channelTableView.reloadData()
        }
    }
}

extension ChannelViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = channelTableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureChannel(channel: channel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}

extension ChannelViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        
        if MessageService.instance.unreadChannels.count > 0 {
            MessageService.instance.unreadChannels = MessageService.instance.unreadChannels.filter({ (id) -> Bool in
                return id != channel.id
            })
        }
        
        let index = IndexPath(row: indexPath.row, section: 0)
        self.channelTableView.reloadRows(at: [index], with: .none)
        self.channelTableView.selectRow(at: index, animated: false, scrollPosition: .none)
        
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        self.revealViewController()?.revealToggle(animated: true)
    }
}
