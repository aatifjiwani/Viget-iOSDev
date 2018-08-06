//
//  Poll.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 7/27/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class Poll: NSObject {
    
    var title: String?
    var userId: Int?
    var id: Int?
    
    var expired: Bool?
    var expireTime: Date?
    
    var optionA: String?
    var optionAUrl: String?
    var optionB: String?
    var optionBUrl: String?
    
    var optionAImgUrl: String?
    var optionBImgUrl: String?
    
    var timeLeft: String?
    
    init(json: [String: Any]) {
        title = json["title"] as? String
        userId = json["user_id"] as? Int
        id = json["id"] as? Int
        
        expired = json["expired"] as? Bool
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        expireTime = formatter.date(from: json["expiry_time"] as! String)
        
        optionA = json["option_a"] as? String
        optionAUrl = json["option_a_url"] as? String
        optionB = json["option_b"] as? String
        optionBUrl = json["option_b_url"] as? String
        
        optionAImgUrl = json["option_a_img"] as? String
        optionBImgUrl = json["option_b_img"] as? String
        
        timeLeft = json["time"] as? String
    }
    
    func getOptionAImg() -> String? {
        if !(optionAUrl?.isEmpty)! {
            return optionAUrl
        } else if !(optionAImgUrl?.isEmpty)! {
            return optionAImgUrl
        } else {
            return ""
        }
    }
    
    func getOptionBImg() -> String? {
        if !(optionBUrl?.isEmpty)! {
            return optionBUrl
        } else if !(optionBImgUrl?.isEmpty)! {
            return optionBImgUrl
        } else {
            return ""
        }
    }
}
