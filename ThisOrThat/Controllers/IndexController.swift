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
    
    let feedLabel: UIButton = {
        let label = UIButton(type: .system)
        label.setTitle("FEED", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.setTitleColor(UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1), for: .normal)
        return label
    }()
    
    let pollLabel: UIButton = {
        let label = UIButton(type: .system)
        label.setTitle("MY POLLS", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.setTitleColor(UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1), for: .normal)
        return label
    }()
    
    let followingLabel: UIButton = {
        let label = UIButton(type: .system)
        label.setTitle("FOLLOWING", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.setTitleColor(UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1), for: .normal)
        return label
    }()
    
    let signUpLabel: UIButton = {
        let label = UIButton(type: .system)
        label.setTitle("Sign up", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.setTitleColor(UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1), for: .normal)
        label.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return label
    }()
    
    let logInLabel: UIButton = {
        let label = UIButton(type: .system)
        label.setTitle("Log in", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.setTitleColor(UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1), for: .normal)
        label.addTarget(self, action: #selector(handleLoginIn), for: .touchUpInside)
        return label
    }()
    
    var headerHeightAnchor: NSLayoutConstraint?
    
    let triangle = TriangleView(frame: CGRect(x: 10, y: 20, width: 10, height: 10))
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
        
        triangle.backgroundColor = .white
        headerContainerView.addSubview(triangle)
        triangle.anchor(headerContainerView.topAnchor, left: nil, bottom: nil, right: headerContainerView.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 10, heightConstant: 10)
        triangle.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        
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
        logInLabel.anchor(headerContainerView.topAnchor, left: nil, bottom: nil, right: headerContainerView.rightAnchor, topConstant: 25, leftConstant: 0, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 0)
        logInLabel.sizeToFit()
        
        headerContainerView.addSubview(signUpLabel)
        signUpLabel.anchor(headerContainerView.topAnchor, left: nil, bottom: nil, right: logInLabel.rightAnchor, topConstant: 25, leftConstant: 0, bottomConstant: 0, rightConstant: 70, widthConstant: 0, heightConstant: 0)
        signUpLabel.sizeToFit()
    }
    
    func setupLoggedIn() {
        if UserDefaults.standard.isLoggedIn() {
            changeHiddenValue(toValue: false)
            headerHeightAnchor?.constant = 150
        } else {
            changeHiddenValue(toValue: true)
            headerHeightAnchor?.constant = 100
        }
    }
    
    @objc func handleLoginIn() {
        UserDefaults.standard.setIsLoggedIn(value: true)
        changeHiddenValue(toValue: false)
        headerHeightAnchor?.constant = 150
    }
    
    @objc func handleSignUp() {
        UserDefaults.standard.setIsLoggedIn(value: false)
        changeHiddenValue(toValue: true)
        headerHeightAnchor?.constant = 100
    }
    
    func changeHiddenValue(toValue value: Bool) {
        followingLabel.isHidden = value
        pollLabel.isHidden = value
        feedLabel.isHidden = value
        triangle.isHidden = value
    }
}
