//
//  AppDetailController.swift
//  appstore
//
//  Created by Aatif Jiwani on 7/10/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class AppDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var app: App? {
        didSet {
            if app?.screenshots != nil {
                return
            }
            
            if let id = app?.id {
                let urlString = "https://api.letsbuildthatapp.com/appstore/appdetail?id=\(id)"
                URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: {
                    (data, response, error) -> Void in
                    
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    do {
                        let json = try(JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! [String: Any]
                        
                        let appDetail = App()
                        appDetail.setValuesForKeys(json)
                        self.app = appDetail
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.collectionView?.reloadData()
                        })
                        
                    } catch let err {
                        print(err)
                    }
                    
                }).resume()
            }
        }
    }
    
    private let screenshotID = "screenShotID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(AppDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "appDetailHeader")
        collectionView?.register(ScreenshotCell.self, forCellWithReuseIdentifier: screenshotID)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenshotID, for: indexPath) as! ScreenshotCell
        cell.app = self.app!
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 170)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "appDetailHeader", for: indexPath) as! AppDetailHeader
        header.app = app
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 170)
    }
}

class AppDetailHeader: BaseCell {
    var app: App? {
        didSet {
            if let imgName = app?.imageName {
                imageView.image = UIImage(named: imgName)
            }
            
            if let name = app?.name {
                nameLabel.text = name
            }
            
            if let price = app?.price {
                buyButton.setTitle("$\(price)", for: .normal)
            } else {
                buyButton.setTitle("Free", for: .normal)
            }
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "replace"
        lbl.font = UIFont.systemFont(ofSize: 16)
        return lbl
    }()
    
    let segmentControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Details", "Reviews", "Related"])
        sc.selectedSegmentIndex = 0
        sc.tintColor = UIColor.darkGray;
        return sc
    }()
    
    let buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("price", for: .normal)
        button.layer.borderColor = UIColor(red: 0, green: 129/255, blue: 250/255, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor.white
        addSubview(imageView)
        addSubview(segmentControl)
        addSubview(nameLabel)
        addSubview(buyButton)
        addSubview(dividerLine)
        
        addContstraintsWithFormat(format: "H:|-14-[v0(100)]-8-[v1]|", views: imageView, nameLabel)
        addContstraintsWithFormat(format: "V:|-14-[v0(100)]", views: imageView)
        addContstraintsWithFormat(format: "V:|-14-[v0(20)]", views: nameLabel)

        addContstraintsWithFormat(format: "H:|-40-[v0]-40-|", views: segmentControl)
        addContstraintsWithFormat(format: "V:[v0(32)]-10-[v1(34)]-8-|", views: buyButton, segmentControl)
        addContstraintsWithFormat(format: "H:[v0(60)]-14-|", views: buyButton)
        
        addContstraintsWithFormat(format: "H:|[v0]|", views: dividerLine)
        addContstraintsWithFormat(format: "V:[v0(0.5)]|", views: dividerLine)

        
    }
}

extension UIView {
    func addContstraintsWithFormat(format: String, views: UIView...) {
        var viewsStringDict = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsStringDict[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsStringDict))
    }
}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
    
}
