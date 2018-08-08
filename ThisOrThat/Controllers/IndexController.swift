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
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(PollCell.self, forCellWithReuseIdentifier: pollCellID)
        collectionView?.register(PopularRecentCell.self, forCellWithReuseIdentifier: popularRecentCellID)
        collectionView?.register(LoadingPollCell.self, forCellWithReuseIdentifier: loadingPollCellID)
        collectionView?.alwaysBounceVertical = true
//
//        UIFont.familyNames.forEach({ familyName in
//            let fontNames = UIFont.fontNames(forFamilyName: familyName)
//            print(familyName, fontNames)
//        })
        
        configureNavBar()
        setupHeader()
        setupLoggedIn()
        fetchPolls()
    }
    
    var polls = [Poll]()
    var isOnPopular = false
    var loadingCounter = 0
    var isLoading = false
    
    func fetchPolls(filter: String? = nil, popular: Bool = false) {
        isLoading = true
        collectionView?.reloadData()
        
        if let filteredString = filter {
            currentFilter = filter
            APIServices.getUserPolls(filter: filteredString, user_id: UserDefaults.standard.getUser()) { (response) in
                self.reloadCollectionViewWithResponse(response: response)
            }
        } else {
            currentFilter = "feed"
            if popular {
                isOnPopular = true
                APIServices.getPolls(filter: "popular") { (response) in
                    self.reloadCollectionViewWithResponse(response: response)
                }
            } else {
                isOnPopular = false
                APIServices.getPolls { (response) in
                    self.reloadCollectionViewWithResponse(response: response)
                }
            }

        }
    }
    
    func reloadCollectionViewWithResponse(response: [String:Any]) {
        if response["status"] as! String == "success" {
            if let polls = response["poll"] as? NSArray {
                for poll in polls {
                    let individual = poll as! [String: Any]
                    self.polls.append(Poll(json: individual))
                }
                isLoading = false
                self.collectionView?.reloadData()
            }
        }
    }
    
    let pollCellID = "pollCellID"
    let popularRecentCellID = "popularRecentID"
    let loadingPollCellID = "loadingPollCellID"
    var currentHeaderState = "feed"
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard !isLoading else {
            if currentHeaderState == "feed" {
                return 5
            } else {
                return 4
            }
        }
        
        if currentHeaderState == "feed" {
            return polls.count + 1
        } else {
            return polls.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 && currentHeaderState == "feed" {
            return CGSize(width: view.frame.width, height: 70)
        } else {
            return CGSize(width: view.frame.width, height: 340)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard !isLoading else {
            if indexPath.item == 0 && currentHeaderState == "feed" {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: popularRecentCellID, for: indexPath) as! PopularRecentCell
                cell.indexController = self
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: loadingPollCellID, for: indexPath) as! LoadingPollCell
                cell.whichColor = (loadingCounter % 2 == 0)
                loadingCounter += 1
                return cell
            }
        }

        if indexPath.item == 0 && currentHeaderState == "feed" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: popularRecentCellID, for: indexPath) as! PopularRecentCell
            cell.indexController = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pollCellID, for: indexPath) as! PollCell

            var itemIndex = indexPath.item
            if currentHeaderState == "feed" {
                itemIndex = itemIndex - 1
            }

            cell.poll = polls[itemIndex]
            cell.indexController = self
            return cell
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 0.0, bottom: 5.0, right: 0.0)
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
        label.addTarget(self, action: #selector(handleMyPolls), for: .touchUpInside)
        return label
    }()
    
    let followingLabel: UIButton = {
        let label = UIButton(type: .system)
        label.setTitle("FOLLOWING", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.setTitleColor(UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1), for: .normal)
        label.addTarget(self, action: #selector(handleFollowing), for: .touchUpInside)
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
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let squiggly: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "squiggle")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var headerHeightAnchor: NSLayoutConstraint?
    var partialWhiteBackground: UIView?
    let triangle = TriangleView(frame: CGRect(x: 10, y: 20, width: 10, height: 10))
    var loginView: LoginView?
    var signupView: SignupView?
    var optionsView: UserOptionsView?
    var user: User?
    var squigglyCenterAnchor: NSLayoutConstraint?
    var currentFilter: String?
    var partialWhiteBackgroundGesture: UITapGestureRecognizer?
}

extension IndexController {
    func configureNavBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func changeToSinglePollView(poll: Poll?) {
        let singlePollLayout = UICollectionViewFlowLayout()
        singlePollLayout.minimumInteritemSpacing = 0
        let singlePollView = SinglePollController(collectionViewLayout: singlePollLayout)
        singlePollView.poll = poll
        singlePollView.user = user
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        present(singlePollView, animated: false) {
            singlePollView.indexController = self
        }
    }
    
    @objc func handleFeed() {
        if currentFilter != "feed" {
            currentHeaderState = "feed"
            polls.removeAll()
            collectionView?.reloadData()
            squigglyCenterAnchor?.isActive = false
            squigglyCenterAnchor = squiggly.centerXAnchor.constraint(equalTo: feedLabel.centerXAnchor)
            squigglyCenterAnchor?.isActive = true
            fetchPolls(filter: nil, popular: isOnPopular)
        }
    }
    
    @objc func handleMyPolls() {
        print("My polls")
        if currentFilter != "mypolls" {
            currentHeaderState = "mypolls"
            polls.removeAll()
            collectionView?.reloadData()
            squigglyCenterAnchor?.isActive = false
            squigglyCenterAnchor = squiggly.centerXAnchor.constraint(equalTo: pollLabel.centerXAnchor)
            squigglyCenterAnchor?.isActive = true
            fetchPolls(filter: "mypolls", popular: isOnPopular)
        }
    }
    
    @objc func handleFollowing() {
        print("Following")
        if currentFilter != "following" {
            currentHeaderState = "following"
            polls.removeAll()
            collectionView?.reloadData()
            squigglyCenterAnchor?.isActive = false
            squigglyCenterAnchor = squiggly.centerXAnchor.constraint(equalTo: followingLabel.centerXAnchor)
            squigglyCenterAnchor?.isActive = true
            fetchPolls(filter: "following", popular: isOnPopular)
        }
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
        triangle.isUserInteractionEnabled = true
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
        
        headerContainerView.addSubview(squiggly)
        squiggly.topAnchor.constraint(equalTo: feedLabel.bottomAnchor, constant: -15).isActive = true
        squigglyCenterAnchor = squiggly.centerXAnchor.constraint(equalTo: feedLabel.centerXAnchor)
        squigglyCenterAnchor?.isActive = true
        squiggly.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    func setupLoggedIn(new: Bool = false) {
        if UserDefaults.standard.isLoggedIn() {
            changeHiddenValue(toValue: false)
            headerHeightAnchor?.constant = 150
            let userTap = UITapGestureRecognizer(target: self, action: #selector(handleUserOptions))
            let triTap = UITapGestureRecognizer(target: self, action: #selector(handleUserOptions))
            if new {
                headerContainerView.addSubview(usernameLabel)
                triangle.addGestureRecognizer(triTap)
                usernameLabel.text = user?.username
                usernameLabel.anchor(headerContainerView.topAnchor, left: nil, bottom: nil, right: headerContainerView.rightAnchor, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 40, widthConstant: 0, heightConstant: 0)
                usernameLabel.sizeToFit()
                usernameLabel.addGestureRecognizer(userTap)
            } else {
                APIServices.getUser(id: UserDefaults.standard.getUser()) { (response) in
                    let responseUser = User(json: response)
                    self.user = responseUser
                    self.headerContainerView.addSubview(self.usernameLabel)
                    self.triangle.addGestureRecognizer(triTap)
                    self.usernameLabel.text = self.user?.username
                    self.usernameLabel.anchor(self.headerContainerView.topAnchor, left: nil, bottom: nil, right: self.headerContainerView.rightAnchor, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 40, widthConstant: 0, heightConstant: 0)
                    self.usernameLabel.sizeToFit()
                    self.usernameLabel.addGestureRecognizer(userTap)
                }
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
    
    @objc func handleUserOptions(sender: UITapGestureRecognizer) {
        optionsView = UserOptionsView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        optionsView?.indexController = self
        optionsView?.alpha = 0
        
        if let window = UIApplication.shared.keyWindow {
            partialWhiteBackground = UIView(frame: window.frame)
            partialWhiteBackground?.backgroundColor = UIColor.white
            partialWhiteBackground?.alpha = 0
            
            window.addSubview(partialWhiteBackground!)
            window.addSubview(optionsView!)
            
            optionsView?.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: window.frame.width - 50, heightConstant: 100)
            optionsView?.anchorCenterXToSuperview()
            optionsView?.anchorCenterYToSuperview()
            
            partialWhiteBackground?.isUserInteractionEnabled = true
            partialWhiteBackgroundGesture = UITapGestureRecognizer(target: self, action: #selector(handleCancelUserOptions))
            partialWhiteBackground?.addGestureRecognizer(partialWhiteBackgroundGesture!)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.optionsView?.alpha = 1
                self.partialWhiteBackground?.alpha = 0.7
            }, completion: nil)
        }
    }
    
    @objc func handleCancelUserOptions() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.optionsView?.alpha = 0
            self.partialWhiteBackground?.alpha = 0
        }, completion: { (completed) in
            self.optionsView?.removeFromSuperview()
            self.partialWhiteBackground?.removeFromSuperview()
            self.partialWhiteBackground?.removeGestureRecognizer(self.partialWhiteBackgroundGesture!)
        })
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
    
    func logoutUser() {
        handleCancelUserOptions()
        changeHiddenValue(toValue: true)
        usernameLabel.removeFromSuperview()
        headerHeightAnchor?.constant = 100
        handleFeed()
    }
    
    func changeHiddenValue(toValue value: Bool) {
        squiggly.isHidden = value
        followingLabel.isHidden = value
        pollLabel.isHidden = value
        feedLabel.isHidden = value
        triangle.isHidden = value
        signUpLabel.isHidden = !value
        logInLabel.isHidden = !value
    }
}

