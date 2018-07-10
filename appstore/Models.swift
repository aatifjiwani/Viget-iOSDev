//
//  Models.swift
//  appstore
//
//  Created by Aatif Jiwani on 7/9/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class FeaturedApps: NSObject {
    @objc var bannerCategory: AppCategory?
    @objc var appCategories: [AppCategory]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "categories" {
            appCategories = [AppCategory]()
            for dict in value as! [[String: Any]] {
                let appCategory = AppCategory()
                appCategory.setValuesForKeys(dict)
                appCategories?.append(appCategory)
            }
        } else if key == "bannerCategory" {
            bannerCategory = AppCategory()
            bannerCategory?.setValuesForKeys(value as! [String: Any])
        } else {
            super.setValue(value, forKey: key)
        }
    }
}

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
    
    static func fetchAllApps(completionHandler: @escaping (FeaturedApps) -> ()) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/featured"
        URLSession.shared.dataTask(with: URL(string: urlString)!) {
            (data, response, error) -> Void in
            
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let json = try(JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! [String: Any]
                
                let featuredApps = FeaturedApps()
                featuredApps.setValuesForKeys(json)
                
                DispatchQueue.main.async(execute: { () -> Void in
                    completionHandler(featuredApps)
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
