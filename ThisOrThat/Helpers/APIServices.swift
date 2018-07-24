//
//  APIServices.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 7/24/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIServices {
    static let baseURL = "https://this-or-that-viget.herokuapp.com"
    
    static func loginUser(email: String, password: String, completion: @escaping ([String: Any]) -> ()) {
        let url = "\(baseURL)/api/sessions?token=\(Secrets.appKey)"
        let json: Parameters = [
            "user": [
                "email": email,
                "password": password
            ]
        ]
        
        Alamofire.request(url, method: .post, parameters: json).responseJSON { (response) in
            if let json = response.result.value as? [String : Any] {
                completion(json)
            }
        }
        
    }
}
