//
//  SinglePollController.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 8/7/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class SinglePollController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor(red: 250, green: 250, blue: 250, alpha: 1)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(CommentCell.self, forCellWithReuseIdentifier: commentID)
        setupViews()
        checkIfUserLoggedIn()
    }
    
    var indexController: IndexController?
    
    let headerContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 250, green: 250, blue: 250, alpha: 1)
        
        view.dropShadow(color: UIColor.black, offSet: CGSize(width: -1, height: 1), radius: 20)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What Should I Eat?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "NiveauGroteskBold", size: 30)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    let goBackButton: UIButton = {
        let label = UIButton(type: .system)
        label.setTitle("Go Back", for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        label.setTitleColor(UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1), for: .normal)
        return label
    }()
    
    let pollInfoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 250, green: 250, blue: 250, alpha: 1)
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    
    let followLabel: UILabel = {
        let label = UILabel()
        label.text = "following"
        label.textColor = UIColor(red: 20/255, green: 75/255, blue: 113/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let voteLabel: UILabel = {
        let label = UILabel()
        label.text = "56 votes"
        label.textColor = UIColor(red: 20/255, green: 75/255, blue: 113/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "7 days left"
        label.textColor = UIColor(red: 20/255, green: 75/255, blue: 113/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let voteIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "fire-icon")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let clockIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "clock-icon")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let followIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "follow-icon")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let optionAView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.backgroundColor = UIColor(red: 91/255, green: 183/255, blue: 242/255, alpha: 1)
        view.layer.cornerRadius = 100
        return view
    }()
    
    let optionBView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.backgroundColor = UIColor(red: 252/255, green: 185/255, blue: 44/255, alpha: 1)
        return view
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "Comments"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "NiveauGroteskBold", size: 16)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    let commentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 250, green: 250, blue: 250, alpha: 1)
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    
    let commentUserNameLabel: UILabel = {
        let label = UILabel()
        label.text = "username"
        label.textColor = UIColor(red: 61/255, green: 62/255, blue: 68/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        return label
    }()
    
    let optionALabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.textColor = UIColor.white
        label.font = UIFont(name: "NiveauGroteskBold", size: 20)
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()
    
    let optionBLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.textColor = UIColor.white
        label.font = UIFont(name: "NiveauGroteskBold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 3
        return label
    }()
    
    let optionAImageOverlay: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red: 97/255, green: 183/255, blue: 242/255, alpha: 1)
        view.dropShadow(color:  UIColor(red: 91/255, green: 183/255, blue: 242/255, alpha: 1), opacity: 1.0, offSet: CGSize(width: 0, height: -30), radius: 50)
        view.layer.cornerRadius = 100
        return view
    }()
    
    let optionAImageOverlayLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.textColor = UIColor.white
        label.font = UIFont(name: "NiveauGroteskBold", size: 16)
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()
    
    let optionBImageOverlay: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red: 252/255, green: 185/255, blue: 44/255, alpha: 1)
        view.dropShadow(color: UIColor(red: 252/255, green: 185/255, blue: 44/255, alpha: 1), opacity: 1, offSet: CGSize(width: 0, height: -40), radius: 50)
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 30
        return view
    }()
    
    let optionBImageOverlayLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.textColor = UIColor.white
        label.font = UIFont(name: "NiveauGroteskBold", size: 16)
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()
    
    let commentTextField = ModalTextField()
    
    let commentID = "commentID"
    
    var comments = [Comment]()
    
    var poll: Poll? {
        didSet {
            titleLabel.text = poll?.title
            optionALabel.text = poll?.optionA
            optionAImageOverlayLabel.text = poll?.optionA
            
            optionBLabel.text = poll?.optionB
            optionBImageOverlayLabel.text = poll?.optionB
            
            if (poll?.expired)! {
                clockIcon.image = UIImage(named: "expired-icon")
                timeLabel.text = "expired"
            } else {
                clockIcon.image = UIImage(named: "clock-icon")
                timeLabel.text = "\((poll?.timeLeft)!) left"
            }
            
            if !((poll?.getOptionAImg()?.isEmpty)!) {
                optionAView.loadImagesUsingCacheWithURLString(url: (poll?.getOptionAImg())!)
                optionALabel.isHidden = true
                optionAImageOverlayLabel.isHidden = false
                optionAImageOverlay.isHidden = false
            } else {
                optionAImageOverlayLabel.isHidden = true
                optionAImageOverlay.isHidden = true
                optionALabel.isHidden = false
                optionAView.image = nil
            }
            
            if !((poll?.getOptionBImg()?.isEmpty)!) {
                optionBView.loadImagesUsingCacheWithURLString(url: (poll?.getOptionBImg())!)
                optionBLabel.isHidden = true
                optionBImageOverlayLabel.isHidden = false
                optionBImageOverlay.isHidden = false
            } else {
                optionBImageOverlayLabel.isHidden = true
                optionBImageOverlay.isHidden = true
                optionBLabel.isHidden = false
                optionBView.image = nil
            }
            
            APIServices.getComments(poll_id: (poll?.id)!) { (response) in
                if response["status"] as? String == "success" {
                    let commentArray = response["comment"] as! NSArray
                    for comment in commentArray {
                        let individualComment = comment as! [String:Any]
                        let commentObject = Comment(json: individualComment)
                        self.comments.append(commentObject)
                        self.collectionView?.reloadData()
                    }
                }
            }
        }
    }
    
    var user: User? {
        didSet {
            commentUserNameLabel.text = user?.username
            APIServices.getFollow(poll_id: poll?.id, user_id: UserDefaults.standard.getUser()) { (response) in
                if response["status"] as! String == "success" {
                    self.setFollows(follow: response["follow"] as! Bool)
                }
            }
        }
    }
    
    func setFollows(follow: Bool) {
        if follow {
            followIcon.image = UIImage(named: "following-icon")
            followLabel.text = "following"
        } else {
            followIcon.image = UIImage(named: "follow-icon")
            followLabel.text = "follow"
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: heightForCommentCell(indexPath: indexPath) + 10)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentID, for: indexPath) as! CommentCell
        cell.comment = self.comments[indexPath.item]
        return cell
    }
    
    @objc func handleFollow() {
        if followLabel.text == "follow" {
            followIcon.image = UIImage(named: "following-icon")
            followLabel.text = "following"
            
            APIServices.makeFollow(method: "POST", user_id: UserDefaults.standard.getUser(), poll_id: (poll?.id)!) { (response) in
                if response["status"] as? String == "success" {
                    if response["follow"] as! Bool {
                        return
                    } else {
                        self.followIcon.image = UIImage(named: "follow-icon")
                        self.followLabel.text = "follow"
                    }
                }
            }
            
        } else {
            followIcon.image = UIImage(named: "follow-icon")
            followLabel.text = "follow"
            APIServices.makeFollow(method: "DELETE", user_id: UserDefaults.standard.getUser(), poll_id: (poll?.id)!) { (response) in
                if response["status"] as? String == "success" {
                    if !(response["follow"] as! Bool) {
                        return
                    } else {
                        self.followIcon.image = UIImage(named: "following-icon")
                        self.followLabel.text = "follow"
                    }
                }
            }
        }
    }
    
    func heightForCommentCell(indexPath: IndexPath) -> CGFloat{
        let cell = CommentCell()
        cell.comment = self.comments[indexPath.item]
        cell.setupViews()
        var h = CGFloat(cell.commentLabel.sizeThatFits(CGSize(width: view.frame.width - 140, height: 200)).height)
        h.round(.up)
        print(h)
        return h
    }
    
    @objc func handleGoBack() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false) {}
    }
    
    func checkIfUserLoggedIn() {
        if UserDefaults.standard.isLoggedIn() {
            commentView.isHidden = false
            collectionViewTopAnchor?.isActive = false
            collectionViewTopAnchor = collectionView?.topAnchor.constraint(equalTo: commentView.bottomAnchor)
            collectionViewTopAnchor?.isActive = true
        } else {
            commentView.isHidden = true
            collectionViewTopAnchor?.isActive = false
            collectionViewTopAnchor = collectionView?.topAnchor.constraint(equalTo: pollInfoView.bottomAnchor)
            collectionViewTopAnchor?.isActive = true
        }
    }
    
    var collectionViewTopAnchor: NSLayoutConstraint?
    
    func setupViews() {
        view.addSubview(pollInfoView)
        pollInfoView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 125, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 325)
        
        view.addSubview(headerContainerView)
        headerContainerView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 125)
        
        headerContainerView.addSubview(titleLabel)
        titleLabel.anchor(nil, left: nil, bottom: headerContainerView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        titleLabel.anchorCenterXToSuperview()
        titleLabel.sizeToFit()
        
        headerContainerView.addSubview(goBackButton)
        goBackButton.anchor(headerContainerView.topAnchor, left: headerContainerView.leftAnchor, bottom: nil, right: nil, topConstant: 25, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        goBackButton.sizeToFit()
        goBackButton.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        
        pollInfoView.addSubview(voteIcon)
        voteIcon.anchor(pollInfoView.topAnchor, left: pollInfoView.leftAnchor, bottom: nil, right: nil, topConstant: 25, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        
        pollInfoView.addSubview(voteLabel)
        voteLabel.anchor(nil, left: voteIcon.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        voteLabel.centerYAnchor.constraint(equalTo: voteIcon.centerYAnchor).isActive = true
        voteLabel.sizeToFit()
        
        pollInfoView.addSubview(clockIcon)
        clockIcon.anchor(pollInfoView.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 25, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        clockIcon.anchorCenterXToSuperview(constant: -40)
        
        pollInfoView.addSubview(timeLabel)
        timeLabel.anchor(nil, left: clockIcon.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        timeLabel.centerYAnchor.constraint(equalTo: clockIcon.centerYAnchor).isActive = true
        timeLabel.sizeToFit()
        
        pollInfoView.addSubview(followLabel)
        followLabel.anchor(nil, left: nil, bottom: nil, right: pollInfoView.rightAnchor, topConstant: 25, leftConstant: 0, bottomConstant: 0, rightConstant: 25, widthConstant: 0, heightConstant: 0)
        followLabel.centerYAnchor.constraint(equalTo: clockIcon.centerYAnchor).isActive = true
        followLabel.sizeToFit()
        followLabel.isUserInteractionEnabled = true
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollow))
        followLabel.addGestureRecognizer(followTap)
        
        pollInfoView.addSubview(followIcon)
        followIcon.anchor(pollInfoView.topAnchor, left: nil, bottom: nil, right: followLabel.leftAnchor, topConstant: 25, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 20, heightConstant: 20)
        followIcon.isUserInteractionEnabled = true
        let followIconTap = UITapGestureRecognizer(target: self, action: #selector(handleFollow))
        followIcon.addGestureRecognizer(followIconTap)
        
        pollInfoView.addSubview(optionAView)
        optionAView.anchor(voteIcon.bottomAnchor, left: pollInfoView.leftAnchor, bottom: nil, right: nil, topConstant: 35, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: (view.frame.width / 2) - 10, heightConstant: 200)
        optionAView.addSubview(optionALabel)
        optionALabel.centerXAnchor.constraint(equalTo: optionAView.centerXAnchor).isActive = true
        optionALabel.centerYAnchor.constraint(equalTo: optionAView.centerYAnchor).isActive = true
        optionALabel.widthAnchor.constraint(equalTo: optionAView.widthAnchor).isActive = true
        optionALabel.heightAnchor.constraint(equalTo: optionAView.heightAnchor).isActive = true
        
        optionAView.addSubview(optionAImageOverlay)
        optionAImageOverlay.anchor(optionAView.centerYAnchor, left: optionAView.leftAnchor, bottom: nil, right: optionAView.rightAnchor, topConstant: 45, leftConstant: -10, bottomConstant: 0, rightConstant: -10, widthConstant: 0, heightConstant: 0)
        optionAImageOverlay.centerYAnchor.constraint(equalTo: optionAView.bottomAnchor, constant: 20).isActive = true
        
        optionAImageOverlay.addSubview(optionAImageOverlayLabel)
        optionAImageOverlayLabel.anchor(optionAImageOverlay.topAnchor, left: optionAView.leftAnchor, bottom: optionAView.bottomAnchor, right: optionAView.rightAnchor, topConstant: 0, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 0)
        
        pollInfoView.addSubview(optionBView)
        optionBView.anchor(voteIcon.bottomAnchor, left: nil, bottom: nil, right: pollInfoView.rightAnchor, topConstant: 35, leftConstant: 0, bottomConstant: 0, rightConstant: 5, widthConstant: (view.frame.width / 2) - 10, heightConstant: 200)
        optionBView.addSubview(optionBLabel)
        optionBLabel.centerXAnchor.constraint(equalTo: optionBView.centerXAnchor).isActive = true
        optionBLabel.centerYAnchor.constraint(equalTo: optionBView.centerYAnchor).isActive = true
        optionBLabel.widthAnchor.constraint(equalTo: optionBView.widthAnchor).isActive = true
        optionBLabel.heightAnchor.constraint(equalTo: optionBView.heightAnchor).isActive = true
        
        optionBView.addSubview(optionBImageOverlay)
        optionBImageOverlay.anchor(optionBView.centerYAnchor, left: optionBView.leftAnchor, bottom: optionBView.bottomAnchor, right: optionBView.rightAnchor, topConstant: 45, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)


        optionBImageOverlay.addSubview(optionBImageOverlayLabel)
        optionBImageOverlayLabel.anchor(optionBImageOverlay.topAnchor, left: optionBImageOverlay.leftAnchor, bottom: optionBView.bottomAnchor, right: optionBImageOverlay.rightAnchor, topConstant: 0, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 0)
        
        pollInfoView.addSubview(commentLabel)
        commentLabel.anchor(nil, left: nil, bottom: pollInfoView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        commentLabel.anchorCenterXToSuperview()
        commentLabel.sizeToFit()
        
        view.addSubview(commentView)
        commentView.anchor(pollInfoView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        commentView.addSubview(commentUserNameLabel)
        commentUserNameLabel.anchor(nil, left: commentView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 0)
        commentUserNameLabel.centerYAnchor.constraint(equalTo: commentView.centerYAnchor).isActive = true
        commentUserNameLabel.sizeToFit()
        
        commentView.addSubview(commentTextField)
        commentTextField.anchor(nil, left: commentUserNameLabel.rightAnchor, bottom: nil, right: commentView.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 30)
        commentTextField.centerYAnchor.constraint(equalTo: commentView.centerYAnchor).isActive = true
        
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        collectionViewTopAnchor = collectionView?.topAnchor.constraint(equalTo: commentView.bottomAnchor)
        collectionViewTopAnchor?.isActive = true

    }
}
