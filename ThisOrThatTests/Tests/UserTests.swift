//
//  UserTests.swift
//  ThisOrThatTests
//
//  Created by Aatif Jiwani on 8/8/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import XCTest
@testable import ThisOrThat

class UserTests: XCTestCase {
    func testUserGetsProperlyCreated() {
        let user = User.init(json: ["user": UserFactory.createUserJSON(email: "user@example.com", username: "username")])
                
        XCTAssertEqual(user.email!, "user@example.com")
        XCTAssertEqual(user.username!, "username")
    }
}
