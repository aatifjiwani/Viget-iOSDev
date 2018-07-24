//
//  User.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 7/19/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class User: NSObject {
    var isSignedIn: Bool?
    var email: String?
    var id: Int?
    var username: String?
    
    init(json: [String: Any]) {
        guard let userHash = json["user"] as? [String: Any] else {
            return
        }
        
        self.email = userHash["email"] as? String
        self.id = userHash["id"] as? Int
        self.username = userHash["username"] as? String
    }
}
