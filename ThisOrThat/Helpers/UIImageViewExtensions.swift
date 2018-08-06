//
//  UIImageViewExtensions.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 8/6/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

let imgCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImagesUsingCacheWithURLString(url imgURL: String) {
        
        self.image = nil
        
        //check cache for image first
        if let cachedImage = imgCache.object(forKey: imgURL as NSString) {
            self.image = cachedImage
            return
        }
        
        let absUrl = URL(string: imgURL)!
        
        //otherwise download image
        APIServices.getImageFromURL(url: absUrl) { (data) in
            if let downloadedImage = UIImage(data: data) {
                imgCache.setObject(downloadedImage, forKey: imgURL as NSString)
                self.image = UIImage(data: data)
            }
        }
    }
}
