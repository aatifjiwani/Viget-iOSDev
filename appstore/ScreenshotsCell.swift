//
//  ScreenshotsCell.swift
//  appstore
//
//  Created by Aatif Jiwani on 7/10/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class ScreenshotCell: BaseCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var app: App? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let screenID = "screenID"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addSubview(collectionView)
        addSubview(dividerLine)
        addContstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addContstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        addContstraintsWithFormat(format: "H:|[v0]|", views: dividerLine)
        addContstraintsWithFormat(format: "V:[v0(0.5)]|", views: dividerLine)
        
        collectionView.register(ScreenshotImageCell.self, forCellWithReuseIdentifier: screenID)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let c = app?.screenshots?.count {
            return c
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenID, for: indexPath) as! ScreenshotImageCell
        if let name = app?.screenshots?[indexPath.item] {
            cell.imageView.image = UIImage(named: name)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: frame.height - 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
    }
    
    class ScreenshotImageCell: BaseCell {
        let imageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFill
            view.backgroundColor = UIColor.gray
            return view
        }()
        
        override func setupViews() {
            super.setupViews()
            backgroundColor = UIColor.gray
            imageView.layer.masksToBounds = true
            
            addSubview(imageView)
            addContstraintsWithFormat(format: "H:|[v0]|", views: imageView)
            addContstraintsWithFormat(format: "V:|[v0]|", views: imageView)
        }
    }
    
}
