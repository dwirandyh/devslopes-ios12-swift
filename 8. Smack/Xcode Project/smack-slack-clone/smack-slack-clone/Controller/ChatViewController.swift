//
//  ChatViewController.swift
//  smack-slack-clone
//
//  Created by Dwi Randy Herdinanto on 04/02/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var messageText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindTextFieldToKeyboard()
        
        self.initMenuButton()
        self.initNotificationObserver()
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (isSuccess) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
    }
    
    func initMenuButton(){
        self.menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)
    }
    
    func initNotificationObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
    }
    
    func bindTextFieldToKeyboard(){
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatViewController.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func userDataDidChange(_ notification: Notification){
        if AuthService.instance.isLoggedIn {
            // Get channels
            onLoginGetMessages()
        } else {
            channelNameLabel.text = "Please Log In"
        }
    }
    
    @objc func channelSelected(_ notification: Notification){
        updateWithChannel()
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    func updateWithChannel(){
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLabel.text = "#\(channelName)"
        
        self.getMessages()
    }
    
    func onLoginGetMessages(){
        MessageService.instance.findAllChannel { (isSuccess) in
            if isSuccess {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLabel.text = "No channels yet!"
                }
            }
        }
    }
    
    func getMessages(){
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            
        }
    }
    
    @IBAction func sendMessagePressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            guard let message = messageText.text else { return }
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId) { (isSuccess) in
                if isSuccess {
                    self.messageText.text = ""
                    self.messageText.resignFirstResponder()
                }
            }
        }
    }
    
}
