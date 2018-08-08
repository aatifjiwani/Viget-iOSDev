//
//  CommentTests.swift
//  ThisOrThatTests
//
//  Created by Aatif Jiwani on 8/8/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import XCTest
@testable import ThisOrThat

class CommentTests: XCTestCase {
    func testCommentGetsProperlyCreated() {
        let comment = Comment.init(json: CommentFactory.createCommentJSON(body: "Example Comment", username: "username"))
        
        XCTAssertEqual(comment.body!, "Example Comment")
        XCTAssertEqual(comment.username!, "username")
    }
}
