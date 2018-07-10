//
//  ViewController.swift
//  appstore
//
//  Created by Aatif Jiwani on 7/9/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class FeaturedAppsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellID = "cellID"
    var appCategories: [AppCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //appCategories = AppCategory.sampleAppCategories()
        AppCategory.fetchAllApps { (appCategories) -> () in
            self.appCategories = appCategories
            self.collectionView?.reloadData()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCell
        cell.appCategory = appCategories?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategories?.count {
            return count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 2 {
            return CGSize(width: view.frame.width, height: 160)
        }
        return CGSize(width: view.frame.width, height: 230)
    }

}


