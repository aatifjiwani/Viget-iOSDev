//
//  Message.swift
//  gameofchats
//
//  Created by Aatif Jiwani on 7/13/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class Message: NSObject {
    @objc var fromID: String?
    @objc var toID: String?
    @objc var timestamp: NSNumber?
    @objc var text: String?
}
