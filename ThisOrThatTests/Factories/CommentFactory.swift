//
//  CommentFactory.swift
//  ThisOrThatTests
//
//  Created by Aatif Jiwani on 8/8/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import XCTest
@testable import ThisOrThat

enum CommentFactory {
    static var defaultCommentJSON: [String:Any] = [
        "id": 0,
        "user_id": 0,
        "poll_id": 0,
        "created_at": "2018-08-03T17:49:13.529Z",
        "updated_at": "2018-08-03T17:49:13.529Z",
    ]
    
    static func createCommentJSON(body: String = "Example Comment", username: String = "testuser") -> [String: Any] {
        return defaultCommentJSON.merging(["body": body, "username": username], uniquingKeysWith: { (_, new) -> Any in
            new
        })
    }
}
