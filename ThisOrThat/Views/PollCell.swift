//
//  PollCell.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 7/27/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class PollCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let bottomContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        view.clipsToBounds = true
        view.layer.cornerRadius = 27
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    let optionAView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.backgroundColor = UIColor(red: 91/255, green: 183/255, blue: 242/255, alpha: 1)
        return view
    }()
    
    let optionBView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.backgroundColor = UIColor(red: 252/255, green: 185/255, blue: 44/255, alpha: 1)
        return view
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 245/255, blue: 255/255, alpha: 1)
        view.layer.cornerRadius = 68
        view.clipsToBounds = true
        return view
    }()
    
    let titleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("...", for: .normal)
        button.setTitleColor(UIColor(red: 61/255, green: 62/255, blue: 68/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
        return button
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.textColor = UIColor(red: 61/255, green: 62/255, blue: 68/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        return label
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.textColor = UIColor(red: 20/255, green: 75/255, blue: 113/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let followLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.textColor = UIColor(red: 20/255, green: 75/255, blue: 113/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let voteLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.textColor = UIColor(red: 20/255, green: 75/255, blue: 113/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.textColor = UIColor(red: 20/255, green: 75/255, blue: 113/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
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
    
    let commentIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "comment-icon")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let expiredIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "expired-icon")
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
    
    let followingIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "following-icon")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let optionALabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.textColor = UIColor.white
        label.font = UIFont(name: "NiveauGroteskBold", size: 30)
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()
    
    let optionBLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.textColor = UIColor.white
        label.font = UIFont(name: "NiveauGroteskBold", size: 30)
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
    
    var poll: Poll? {
        didSet {
            titleButton.setTitle(poll?.title, for: .normal)
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
            
            APIServices.getUser(id: (poll?.userId)!) { (response) in
                self.user = User(json: response)
            }
            
            APIServices.getCommentCount(poll_id: (poll?.id)!) { (response) in
                if response["status"] as! String == "success" {
                    self.setComments(count: response["comment"] as! Int)
                }
            }
            
            if !((poll?.getOptionAImg()?.isEmpty)!) {
                // print(poll?.title, poll?.getOptionAImg())
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
                // print(poll?.title, poll?.getOptionAImg())
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
        }
    }
    
    var user: User? {
        didSet {
            usernameLabel.text = user?.username
            APIServices.getFollow(poll_id: poll?.id, user_id: UserDefaults.standard.getUser()) { (response) in
                if response["status"] as! String == "success" {
                    self.setFollows(follow: response["follow"] as! Bool)
                }
            }
        }
    }
    
    var indexController: IndexController?
    
    func setComments(count: Int) {
        if count == 1 {
            commentLabel.text = "1 comment"
        } else {
            commentLabel.text = "\(count) comments"
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
    
    @objc func handleSinglePollView(sender: UIButton) {
        indexController?.changeToSinglePollView(poll: poll)
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
    
    func setupViews() {
        backgroundColor = UIColor.white
        
        addSubview(bottomContainerView)
        bottomContainerView.anchor(nil, left: nil, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 355, heightConstant: 40)
        bottomContainerView.anchorCenterXToSuperview()
        
        addSubview(optionBView)
        optionBView.anchor(nil, left: nil, bottom: bottomContainerView.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: frame.width / 2, heightConstant: 230)
        
        addSubview(circleView)
        circleView.anchor(nil, left: leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 135, heightConstant: 135)
        circleView.centerYAnchor.constraint(equalTo: optionBView.topAnchor).isActive = true
        
        addSubview(optionAView)
        optionAView.anchor(nil, left: leftAnchor, bottom: bottomContainerView.topAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: frame.width / 2, heightConstant: 230)
        print(optionAView.frame.size.width)
        
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
        
        
        optionBView.addSubview(optionBLabel)
        optionBLabel.centerXAnchor.constraint(equalTo: optionBView.centerXAnchor).isActive = true
        optionBLabel.centerYAnchor.constraint(equalTo: optionBView.centerYAnchor).isActive = true
        optionBLabel.widthAnchor.constraint(equalTo: optionBView.widthAnchor).isActive = true
        optionBLabel.heightAnchor.constraint(equalTo: optionBView.heightAnchor).isActive = true
        
        optionBView.addSubview(optionBImageOverlay)
        optionBImageOverlay.anchor(optionBView.centerYAnchor, left: optionBView.leftAnchor, bottom: optionBView.bottomAnchor, right: optionBView.rightAnchor, topConstant: 45, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        optionBImageOverlay.addSubview(optionBImageOverlayLabel)
        optionBImageOverlayLabel.anchor(optionBImageOverlay.topAnchor, left: optionBImageOverlay.leftAnchor, bottom: optionBView.bottomAnchor, right: optionBImageOverlay.rightAnchor, topConstant: 0, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 0)
        
        addSubview(headerView)
        headerView.anchor(topAnchor, left: leftAnchor, bottom: optionBView.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        headerView.addSubview(titleButton)
        titleButton.anchor(headerView.topAnchor, left: headerView.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 38, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        titleButton.sizeToFit()
        titleButton.addTarget(self, action: #selector(handleSinglePollView), for: .touchUpInside)

        
        headerView.addSubview(usernameLabel)
        usernameLabel.anchor(titleButton.bottomAnchor, left: headerView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 38, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        usernameLabel.sizeToFit()
        
        headerView.addSubview(voteIcon)
        voteIcon.anchor(nil, left: usernameLabel.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 25, bottomConstant: 0, rightConstant: 0, widthConstant: 16, heightConstant: 16)
        voteIcon.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        
        headerView.addSubview(voteLabel)
        voteLabel.anchor(nil, left: voteIcon.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        voteLabel.centerYAnchor.constraint(equalTo: voteIcon.centerYAnchor).isActive = true
        voteLabel.sizeToFit()
        
        headerView.addSubview(clockIcon)
        clockIcon.anchor(nil, left: voteLabel.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 16, heightConstant: 16)
        clockIcon.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        
        headerView.addSubview(timeLabel)
        timeLabel.anchor(nil, left: clockIcon.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        timeLabel.centerYAnchor.constraint(equalTo: clockIcon.centerYAnchor).isActive = true
        timeLabel.sizeToFit()
        
        bottomContainerView.addSubview(followIcon)
        followIcon.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor).isActive = true
        followIcon.leftAnchor.constraint(equalTo: centerXAnchor, constant: 20).isActive = true
        followIcon.widthAnchor.constraint(equalToConstant: 14).isActive = true
        followIcon.heightAnchor.constraint(equalToConstant: 14).isActive = true
        followIcon.isUserInteractionEnabled = true
        let followIconTap = UITapGestureRecognizer(target: self, action: #selector(handleFollow))
        followIcon.addGestureRecognizer(followIconTap)
        
        bottomContainerView.addSubview(followLabel)
        followLabel.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor).isActive = true
        followLabel.leftAnchor.constraint(equalTo: followIcon.rightAnchor, constant: 10).isActive = true
        followLabel.sizeToFit()
        followLabel.isUserInteractionEnabled = true
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollow))
        followLabel.addGestureRecognizer(followTap)
        
        bottomContainerView.addSubview(commentLabel)
        commentLabel.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor).isActive = true
        commentLabel.rightAnchor.constraint(equalTo: centerXAnchor, constant: -20).isActive = true
        commentLabel.sizeToFit()
        commentLabel.isUserInteractionEnabled = true
        let commentLabelTap = UITapGestureRecognizer(target: self, action: #selector(handleSinglePollView(sender:)))
        commentLabel.addGestureRecognizer(commentLabelTap)
        
        bottomContainerView.addSubview(commentIcon)
        commentIcon.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor).isActive = true
        commentIcon.rightAnchor.constraint(equalTo: commentLabel.leftAnchor, constant: -10).isActive = true
        commentIcon.widthAnchor.constraint(equalToConstant: 14).isActive = true
        commentIcon.heightAnchor.constraint(equalToConstant: 14).isActive = true
        commentIcon.isUserInteractionEnabled = true
        let commentIconTap = UITapGestureRecognizer(target: self, action: #selector(handleSinglePollView(sender:)))
        commentIcon.addGestureRecognizer(commentIconTap)
    }
}
