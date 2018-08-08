//
//  PollFactory.swift
//  ThisOrThatTests
//
//  Created by Aatif Jiwani on 8/8/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import XCTest
@testable import ThisOrThat

enum PollFactory {
    static var defaultPollJSON: [String:Any] = [
        "id": 0,
        "created_at": "2018-08-03T17:51:54.760Z",
        "updated_at": "2018-08-03T17:51:54.760Z",
        "user_id": 0,
        "expiry_time": "2018-08-10T17:51:54.755Z",
        "expired": false,
        "time": "7 days",
        "option_a_url": "",
        "option_b_url": "",
        "option_a_img": "",
        "option_b_img": ""
    ]
    
    static func pollNoImagesJSON(title: String = "Example Poll", optionA: String = "Choice 1", optionB: String = "Choice 2") -> [String: Any] {
        return defaultPollJSON.merging(["title": title, "option_a": optionA, "option_b": optionB], uniquingKeysWith: { (_, new) -> Any in
            new
        })
    }
    
    static func pollWithImagesJSON(title: String = "Example Poll", optionA: String = "Choice 1", optionB: String = "Choice 2") -> [String: Any] {
        return defaultPollJSON.merging(["title": title, "option_a": optionA, "option_b": optionB, "option_a_url": "https://goo.gl/images/BJmksy", "option_b_url": "https://goo.gl/images/BJmksy" ], uniquingKeysWith: { (_, new) -> Any in
            new
        })
    }
}
