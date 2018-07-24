//
//  APIServices.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 7/24/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class APIServices {
    static func loginUser(email: String, password: String) {
        let url = URL(string: "http://this-or-that.co/api/sessions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
    }
}
