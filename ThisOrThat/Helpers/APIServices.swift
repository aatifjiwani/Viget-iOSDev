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
        let url = URL(string: "\(baseURL)/api/sessions?token=\(Secrets.appKey)")!
        let json: [String: Any] = [
            "user": [
                "email": email.trimmingCharacters(in: .whitespacesAndNewlines),
                "password": password.trimmingCharacters(in: .whitespacesAndNewlines)
        ]]
        
        makeAPICallWithResponse(url: url, method: "POST", dict: json) { (response) in
            completion(response)
        }
    }
    
    static func signupUser(username: String, email: String, password: String, confPassword: String, completion: @escaping ([String: Any]) -> ()) {
        let url = URL(string: "\(baseURL)/api/registrations?token=\(Secrets.appKey)")!
        let json: [String: Any] = [
            "user": [
                "username": username.trimmingCharacters(in: .whitespacesAndNewlines),
                "email": email.trimmingCharacters(in: .whitespacesAndNewlines),
                "password": password.trimmingCharacters(in: .whitespacesAndNewlines),
                "password_confirmation": confPassword.trimmingCharacters(in: .whitespacesAndNewlines)
            ]]
        
        makeAPICallWithResponse(url: url, method: "POST", dict: json) { (response) in
            completion(response)
        }
    }
    
    private static func makeAPICallWithResponse(url: URL, method: String, dict: [String: Any], completion: @escaping ([String: Any]) -> ()) {
        let jsonData = self.dictToJSONObject(dict: dict)
        
        // create post request
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = method
        
        // insert json data to the request
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            if error != nil{
                print("Error -> \(error!)")
                return
            }
            
            do {
                let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]
                
                print("Result -> \(result!)")
                DispatchQueue.main.async(execute: {
                    completion(result!)
                })
                
            } catch {
                print("Error -> \(error)")
            }
        }.resume()
    }
    
    private static func dictToJSONObject(dict: [String: Any]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
    }
}
