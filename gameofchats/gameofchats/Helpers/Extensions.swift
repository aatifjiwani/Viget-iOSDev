//
//  Extensions.swift
//  gameofchats
//
//  Created by Aatif Jiwani on 7/13/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit
import Firebase

let imgCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImagesUsingCacheWithURLString(url imgURL: String) {
        
        self.image = nil
        
        //check cache for image first
        if let cachedImage = imgCache.object(forKey: imgURL as NSString) {
            self.image = cachedImage
            return
        }
        
        //otherwise download image
        APICalls.retrieveImageFromFirebase(url: imgURL) { (data) in
            if let downloadedImage = UIImage(data: data) {
                imgCache.setObject(downloadedImage, forKey: imgURL as NSString)
                self.image = UIImage(data: data)
            }
            
        }
    }
}
