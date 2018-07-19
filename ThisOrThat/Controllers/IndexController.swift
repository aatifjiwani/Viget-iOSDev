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
        setupLoggedIn()
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
    
    let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign up"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    let logInLabel: UILabel = {
        let label = UILabel()
        label.text = "Log in"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    var headerHeightAnchor: NSLayoutConstraint?
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
        headerHeightAnchor = headerContainerView.heightAnchor.constraint(equalToConstant: 150)
        headerHeightAnchor?.isActive = true
        
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
        
        headerContainerView.addSubview(logInLabel)
        logInLabel.anchor(headerContainerView.topAnchor, left: nil, bottom: nil, right: headerContainerView.rightAnchor, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 0)
        logInLabel.sizeToFit()
        
        headerContainerView.addSubview(signUpLabel)
        signUpLabel.anchor(headerContainerView.topAnchor, left: nil, bottom: nil, right: logInLabel.rightAnchor, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 70, widthConstant: 0, heightConstant: 0)
        signUpLabel.sizeToFit()
    }
    
    func setupLoggedIn() {
        if UserDefaults.standard.isLoggedIn() {
            print("oohhhh logged in")
            followingLabel.isHidden = false
            pollLabel.isHidden = false
            feedLabel.isHidden = false
            headerHeightAnchor?.constant = 150
        } else {
            followingLabel.isHidden = true
            pollLabel.isHidden = true
            feedLabel.isHidden = true
            headerHeightAnchor?.constant = 100
        }
    }
}

