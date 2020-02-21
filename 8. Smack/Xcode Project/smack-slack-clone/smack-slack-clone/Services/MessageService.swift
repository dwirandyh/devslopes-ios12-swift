//
//  MessageService.swift
//  smack-slack-clone
//
//  Created by Dwi Randy Herdinanto on 15/02/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    
    var channels : [Channel] = [Channel]()
    var messages : [Message] = [Message]()
    var unreadChannels : [String] = [String]()
    var selectedChannel : Channel? = Channel()
    
    func findAllChannel(completion: @escaping CompletionHandler){
        Alamofire.request(URL_CHANNEL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                do {
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let name : String = item["name"].stringValue
                            let channelDescription : String = item["description"].stringValue
                            let id : String = item["_id"].stringValue
                            let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                            self.channels.append(channel)
                        }
                        NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                        completion(true)
                    }
                }catch let error as NSError {
                    debugPrint("MessageService(findAllChannel:", error)
                }
            } else {
                completion(false)
                debugPrint("MessageService(findAllChannel):", response.result.error as Any)
            }
        }
    }
    
    func clearChannels(){
        channels.removeAll()
    }
    
    func findAllMessagesForChannel(channelId : String, completion: @escaping CompletionHandler){
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else { return }
                do {
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let messageBody = item["messageBody"].stringValue
                            let channelId = item["channelId"].stringValue
                            let id = item["_id"].stringValue
                            let userName = item["userName"].stringValue
                            let userAvatar = item["userAvatar"].stringValue
                            let userAvatarColor = item["userAvatarColor"].stringValue
                            let timeStamp = item["timeStamp"].stringValue
                            
                            let message : Message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                            self.messages.append(message)
                        }
                    }
                    completion(true)
                }catch let error as NSError {
                    completion(false)
                    debugPrint("MessageService(findAllMessageForChannel):", error)
                }
            }else {
                completion(false)
                debugPrint("MessageService(findAllMessageForChannel):", response.result.error as Any)
            }
        }
    }
    
    func clearMessages(){
        messages.removeAll()
    }
    
}
