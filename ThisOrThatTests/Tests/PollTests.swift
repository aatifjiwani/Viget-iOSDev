//
//  PollTests.swift
//  ThisOrThatTests
//
//  Created by Aatif Jiwani on 8/8/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import XCTest
@testable import ThisOrThat

class PollTests: XCTestCase {
    
    var optionImageURL = "https://goo.gl/images/BJmksy"
    
    func testPollParsesResponse() {
        let poll = Poll.init(json: PollFactory.pollNoImagesJSON(title: "Example Poll", optionA: "Option 1", optionB: "Option 2"))
        
        XCTAssert(poll.title == "Example Poll", "Poll title does not match")
        XCTAssert(poll.optionA == "Option 1", "Poll Option A does not match")
        XCTAssert(poll.optionB == "Option 2", "Poll Option B does not match")
        
    }
    
    func testPollReturnsEmptyStringIfNoImages() {
        let poll = Poll.init(json: PollFactory.pollNoImagesJSON(title: "Example Poll", optionA: "Option 1", optionB: "Option 2"))
        
        XCTAssert(poll.getOptionAImg()?.isEmpty == true, "Poll returned wrong value for getting Option A image")
        XCTAssert(poll.getOptionBImg()?.isEmpty == true, "Poll returned wrong value for getting Option B image")
    }
    
    func testPollReturnsImageURLIfContainsImages() {
        let poll = Poll.init(json: PollFactory.pollWithImagesJSON(title: "Example Poll", optionA: "Option 1", optionB: "Option 2"))
        
        XCTAssert(poll.getOptionAImg()?.isEmpty == false, "Poll returned wrong value for getting Option A image")
        XCTAssert(poll.getOptionAImg() == optionImageURL, "Poll returned wrong value for getting Option A image")
        
        XCTAssert(poll.getOptionBImg()?.isEmpty == false, "Poll returned wrong value for getting Option B image")
        XCTAssert(poll.getOptionBImg() == optionImageURL, "Poll returned wrong value for getting Option B image")
    }
    
    
}
