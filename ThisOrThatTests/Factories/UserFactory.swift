//
//  UserFactory.swift
//  ThisOrThatTests
//
//  Created by Aatif Jiwani on 8/8/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//


import XCTest
@testable import ThisOrThat

enum UserFactory {
    static var defaultPollJSON: [String:Any] = [
            "id": 0,
            "created_at": "2018-08-03T17:02:49.920Z",
            "updated_at": "2018-08-06T16:54:34.008Z"
    ]
    
    static func createUserJSON(email: String = "user@example.com", username: String = "testuser") -> [String: Any] {
        return defaultPollJSON.merging(["email": email, "username": username], uniquingKeysWith: { (_, new) -> Any in
            new
        })
    }
}

