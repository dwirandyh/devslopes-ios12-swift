//
//  Message.swift
//  smack-slack-clone
//
//  Created by Dwi Randy Herdinanto on 17/02/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import Foundation

struct Message {
    public private(set) var message : String!
    public private(set) var userName : String!
    public private(set) var channelId : String!
    public private(set) var userAvatar : String!
    public private(set) var userAvatarColor : String!
    public private(set) var id : String!
    public private(set) var timeStamp : String!
}
