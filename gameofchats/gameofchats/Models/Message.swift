//
//  Message.swift
//  gameofchats
//
//  Created by Aatif Jiwani on 7/13/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {
    @objc var fromID: String?
    @objc var toID: String?
    @objc var timestamp: NSNumber?
    @objc var text: String?
    @objc var imageURL: String?
    @objc var imageWidth: NSNumber?
    @objc var imageHeight: NSNumber?
    
    func correctToUserID() -> String? {
        if fromID == Auth.auth().currentUser?.uid {
            return toID
        } else {
            return fromID
        }
    }
}
