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
    
    static func getUser(id: Int, completion: @escaping ([String: Any]) -> ()) {
        let url = URL(string: "\(baseURL)/api/users/\(id)?token=\(Secrets.appKey)")!
        makeAPICallWithResponse(url: url, method: "GET", dict: nil) { (response) in
            completion(response)
        }
    }
    
    static func getCommentCount(poll_id: Int, completion: @escaping ([String: Any]) -> ()) {
        let url = URL(string: "\(baseURL)/api/comments/?filter=count&poll_id=\(poll_id)&token=\(Secrets.appKey)")!
        makeAPICallWithResponse(url: url, method: "GET", dict: nil) { (response) in
            completion(response)
        }
    }
    
    static func getComments(poll_id: Int, completion: @escaping ([String: Any]) -> ()) {
        let url = URL(string: "\(baseURL)/api/comments/?poll_id=\(poll_id)&token=\(Secrets.appKey)")!
        makeAPICallWithResponse(url: url, method: "GET", dict: nil) { (response) in
            completion(response)
        }
    }
    
    static func getFollow(poll_id: Int?, user_id: Int?, completion: @escaping ([String: Any]) -> ()) {
        let url = URL(string: "\(baseURL)/api/follows/?user_id=\(user_id!)&poll_id=\(poll_id!)&token=\(Secrets.appKey)")!
        makeAPICallWithResponse(url: url, method: "GET", dict: nil) { (response) in
            completion(response)
        }
    }
    
    static func makeFollow(method: String, user_id: Int, poll_id: Int, completion: @escaping ([String: Any]) -> ()) {
        let url = URL(string: "\(baseURL)/api/follows/?token=\(Secrets.appKey)")!
        let json: [String: Any] = [
            "poll_id": poll_id,
            "user_id": user_id
        ]
        
        makeAPICallWithResponse(url: url, method: method, dict: json) { (response) in
            completion(response)
        }
    }
    
    static func getPolls(completion: @escaping ([String: Any]) -> ()) {
        let url = URL(string: "\(baseURL)/api/polls?token=\(Secrets.appKey)")!
        makeAPICallWithResponse(url: url, method: "GET", dict: nil) { (response) in
            completion(response)
        }
    }
    
    static func getUserPolls(filter: String, user_id: Int?, completion: @escaping ([String: Any]) -> ()) {
        let url = URL(string: "\(baseURL)/api/users/\(user_id!)?filter=\(filter)&token=\(Secrets.appKey)")!
        makeAPICallWithResponse(url: url, method: "GET", dict: nil) { (response) in
            completion(response)
        }
    }
    
    static func getImageFromURL(url: URL, completion: @escaping (Data) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                print("Getting Error -> \(error!)")
                return
            }
            
            DispatchQueue.main.async {
                if let unwrappedData = data {
                    completion(unwrappedData)
                }
            }
        }.resume()
    }
    
    private static func makeAPICallWithResponse(url: URL, method: String, dict: [String: Any]?, completion: @escaping ([String: Any]) -> ()) {
        
        
        // create post request
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = method
        
        // insert json data to the request
        if method == "POST" || method == "DELETE" {
            let jsonData = self.dictToJSONObject(dict: dict!)
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
        }
        
        URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            if error != nil{
                print("Getting Error -> \(error!)")
                return
            }
            
            do {
                let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]
                
                DispatchQueue.main.async(execute: {
                    completion(result!)
                })
                
            } catch {
                print("Parsing Error -> \(error)")
            }
        }.resume()
    }
    
    private static func dictToJSONObject(dict: [String: Any]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
    }
}
