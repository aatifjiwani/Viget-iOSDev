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
        collectionView?.backgroundColor = UIColor.red
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(PollCell.self, forCellWithReuseIdentifier: pollCellID)
        collectionView?.alwaysBounceVertical = true
        configureNavBar()
        setupHeader()
        setupLoggedIn()
    }
    
    let pollCellID = "pollCellID"
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: pollCellID, for: indexPath) as! PollCell
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
        label.addTarget(self, action: #selector(handleFeed), for: .touchUpInside)
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
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    var headerHeightAnchor: NSLayoutConstraint?
    var partialWhiteBackground: UIView?
    let triangle = TriangleView(frame: CGRect(x: 10, y: 20, width: 10, height: 10))
    var loginView: LoginView?
    var signupView: SignupView?
    var user: User? 
}

extension IndexController {
    func configureNavBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc func handleFeed() {
        UserDefaults.standard.setIsLoggedIn(value: false)
    }
    
    func setupHeader() {
        view.addSubview(headerContainerView)
        headerContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerContainerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        headerHeightAnchor = headerContainerView.heightAnchor.constraint(equalToConstant: 150)
        headerHeightAnchor?.isActive = true
        
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.anchor(headerContainerView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        triangle.backgroundColor = .white
        headerContainerView.addSubview(triangle)
        triangle.anchor(headerContainerView.topAnchor, left: nil, bottom: nil, right: headerContainerView.rightAnchor, topConstant: 32, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 10, heightConstant: 10)
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
    
    func setupLoggedIn(new: Bool = false) {
        if UserDefaults.standard.isLoggedIn() {
            changeHiddenValue(toValue: false)
            headerHeightAnchor?.constant = 150
            if new {
                headerContainerView.addSubview(usernameLabel)
                usernameLabel.text = user?.username
                usernameLabel.anchor(headerContainerView.topAnchor, left: nil, bottom: nil, right: headerContainerView.rightAnchor, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 40, widthConstant: 0, heightConstant: 0)
                usernameLabel.sizeToFit()
                
            } else {
                //do stuff
            }
        } else {
            changeHiddenValue(toValue: true)
            headerHeightAnchor?.constant = 100
        }
    }
    
    @objc func handleLoginIn() {
        loginView = LoginView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        loginView?.indexController = self
        loginView?.cancelView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleCancelLogin)))
        loginView?.cancelButton.addTarget(self, action: #selector(self.handleCancelLogin), for: .touchUpInside)
        loginView?.alpha = 0
        if let window = UIApplication.shared.keyWindow {
            partialWhiteBackground = UIView(frame: window.frame)
            partialWhiteBackground?.backgroundColor = UIColor.white
            partialWhiteBackground?.alpha = 0
            window.addSubview(partialWhiteBackground!)
            window.addSubview(loginView!)
            loginView?.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: window.frame.width - 50, heightConstant: window.frame.height - 275)
            loginView?.anchorCenterXToSuperview()
            loginView?.anchorCenterYToSuperview()
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.loginView?.alpha = 1
                self.partialWhiteBackground?.alpha = 0.7
            }, completion: nil)
        }
        
//        UserDefaults.standard.setIsLoggedIn(value: true)
//        changeHiddenValue(toValue: false)
//        headerHeightAnchor?.constant = 150
    }
    
    @objc func handleCancelLogin() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.loginView?.alpha = 0
            self.partialWhiteBackground?.alpha = 0
        }, completion: { (completed) in
            self.loginView?.removeFromSuperview()
            self.partialWhiteBackground?.removeFromSuperview()
        })
    }
    
    @objc func handleSignUp() {
        UserDefaults.standard.setIsLoggedIn(value: false)
        signupView = SignupView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        signupView?.indexController = self
        signupView?.cancelView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleCancelSignup)))
        signupView?.cancelButton.addTarget(self, action: #selector(self.handleCancelSignup), for: .touchUpInside)
        signupView?.alpha = 0
        if let window = UIApplication.shared.keyWindow {
            partialWhiteBackground = UIView(frame: window.frame)
            partialWhiteBackground?.backgroundColor = UIColor.white
            partialWhiteBackground?.alpha = 0
            window.addSubview(partialWhiteBackground!)
            window.addSubview(signupView!)
            signupView?.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: window.frame.width - 50, heightConstant: window.frame.height - 225)
            signupView?.anchorCenterXToSuperview()
            signupView?.anchorCenterYToSuperview()
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.signupView?.alpha = 1
                self.partialWhiteBackground?.alpha = 0.7
            }, completion: nil)
        }
//        UserDefaults.standard.setIsLoggedIn(value: false)
//        changeHiddenValue(toValue: true)
//        headerHeightAnchor?.constant = 100
    }
    
    @objc func handleCancelSignup() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.signupView?.alpha = 0
            self.partialWhiteBackground?.alpha = 0
        }, completion: { (completed) in
            self.signupView?.removeFromSuperview()
            self.partialWhiteBackground?.removeFromSuperview()
        })
    }
    
    func changeHiddenValue(toValue value: Bool) {
        followingLabel.isHidden = value
        pollLabel.isHidden = value
        feedLabel.isHidden = value
        triangle.isHidden = value
        signUpLabel.isHidden = !value
        logInLabel.isHidden = !value
    }
}

