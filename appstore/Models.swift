//
//  Models.swift
//  appstore
//
//  Created by Aatif Jiwani on 7/9/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class AppCategory: NSObject {
    @objc var name: String?
    @objc var apps: [App]?
    @objc var type: String?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "apps" {
            apps = [App]()
            for dict in value as! [[String: AnyObject]] {
                let app = App()
                app.setValuesForKeys(dict)
                apps?.append(app)
            }
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    static func fetchAllApps(completionHandler: @escaping ([AppCategory]) -> ()) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/featured"
        URLSession.shared.dataTask(with: URL(string: urlString)!) {
            (data, response, error) -> Void in
            
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let json = try(JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! [String: Any]
                
                var appCategories = [AppCategory]()
                
                for dict in json["categories"] as! [[String : AnyObject]]{
                    let appCategory = AppCategory()
                    appCategory.setValuesForKeys(dict)
                    appCategories.append(appCategory)
                }
                
                DispatchQueue.main.async(execute: { () -> Void in
                    completionHandler(appCategories)
                })
                
            } catch let err {
                print(err)
            }
            
        }.resume()
    }
}

class App: NSObject {
    @objc var name: String?
    @objc var id: NSNumber?
    @objc var category: String?
    @objc var price: NSNumber?
    @objc var imageName: String?
}
