//
//  Comment.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 8/7/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class Comment: NSObject {
    var body: String?
    var username: String?
    
    init(json: [String: Any]) {
        super.init()
        body = json["body"] as? String
        username = json["username"] as? String
        username = username?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
