//
//  APICalls.swift
//  gameofchats
//
//  Created by Aatif Jiwani on 7/12/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import Firebase
class APICalls {
    static func retrieveImageFromFirebase(url: String, completion: @escaping (Data) -> ()) {
        
        let absUrl = URL(string: url)
        URLSession.shared.dataTask(with: absUrl!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async(execute: {
                completion(data!)
            })
        }.resume()
//        Storage.storage().reference(forURL: url).getData(maxSize: 1 * 1024 * 1024) { (data, error) in
//            if let error = error {
//                print("uh oh \(error)")
//            }
//            DispatchQueue.main.async(execute: {
////                completion(UIImage(data: data!)!)
//            })
//        }.resume()

    }
}
