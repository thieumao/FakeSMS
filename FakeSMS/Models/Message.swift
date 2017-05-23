//
//  Message.swift
//  FakeSMS
//
//  Created by Nguyen Van Thieu B on 5/23/17.
//  Copyright © 2017 Hay Nhanh. All rights reserved.
//

import Foundation

class Message {

    var value: String
    var isFriend: Bool

    init(value: String, isFriend: Bool = true) {
        self.value = value
        self.isFriend = isFriend
    }
    
}
