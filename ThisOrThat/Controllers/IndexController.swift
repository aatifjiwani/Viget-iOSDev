//
//  IndexController.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 7/19/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class IndexController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        configureNavBar()
        setupHeader()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let headerContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 250, green: 250, blue: 250, alpha: 1)
        view.dropShadow(color: UIColor.black, offSet: CGSize(width: -1, height: 1), radius: 20)
        return view
    }()
    
    let logoView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let feedLabel: UILabel = {
        let label = UILabel()
        label.text = "FEED"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    let pollLabel: UILabel = {
        let label = UILabel()
        label.text = "MY POLLS"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        label.text = "FOLLOWING"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
}

extension IndexController {
    func configureNavBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupHeader() {
        view.addSubview(headerContainerView)
        headerContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerContainerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        headerContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        headerContainerView.addSubview(logoView)
        logoView.anchor(headerContainerView.topAnchor, left: headerContainerView.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 75, heightConstant: 75)
        
        headerContainerView.addSubview(pollLabel)
        pollLabel.anchorCenterXToSuperview()
        pollLabel.anchor(nil, left: nil, bottom: headerContainerView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 20, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        pollLabel.sizeToFit()
        
        headerContainerView.addSubview(feedLabel)
        feedLabel.anchor(nil, left: nil, bottom: headerContainerView.bottomAnchor, right: pollLabel.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 20, rightConstant: 55, widthConstant: 0, heightConstant: 0)
        feedLabel.sizeToFit()
        
        headerContainerView.addSubview(followingLabel)
        followingLabel.anchor(nil, left: pollLabel.rightAnchor, bottom: headerContainerView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 40, bottomConstant: 20, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        followingLabel.sizeToFit()
        
        
    }
}

