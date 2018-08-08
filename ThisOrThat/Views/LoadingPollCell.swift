//
//  LoeadingPollCell.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 8/8/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class LoadingPollCell: UICollectionViewCell {
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
        view.backgroundColor = UIColor(red: 91/255, green: 183/255, blue: 242/255, alpha: 1)
        return view
    }()
    
    let optionBView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
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
    
    let titleButton: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 182/255, green: 225/255, blue: 252/255, alpha: 1)
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 11
        return view
    }()
    
    let usernameLabel: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 182/255, green: 225/255, blue: 252/255, alpha: 1)
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 7
        return view
    }()
    
    let commentLabel: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 182/255, green: 225/255, blue: 252/255, alpha: 1)
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 7
        return view
    }()
    
    let followLabel: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 182/255, green: 225/255, blue: 252/255, alpha: 1)
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 7
        return view
    }()
    
    let voteLabel: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 182/255, green: 225/255, blue: 252/255, alpha: 1)
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 7
        return view
    }()
    
    let timeLabel: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 182/255, green: 225/255, blue: 252/255, alpha: 1)
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 7
        return view
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
    
    let followIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "follow-icon")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    
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
        
        addSubview(headerView)
        headerView.anchor(topAnchor, left: leftAnchor, bottom: optionBView.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        headerView.addSubview(titleButton)
        titleButton.anchor(headerView.topAnchor, left: headerView.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 38, bottomConstant: 0, rightConstant: 0, widthConstant: frame.width / 2, heightConstant: 22)
        
        
        headerView.addSubview(usernameLabel)
        usernameLabel.anchor(titleButton.bottomAnchor, left: headerView.leftAnchor, bottom: nil, right: nil, topConstant: 13, leftConstant: 38, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 14)
        
        headerView.addSubview(voteIcon)
        voteIcon.anchor(nil, left: usernameLabel.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 25, bottomConstant: 0, rightConstant: 0, widthConstant: 16, heightConstant: 16)
        voteIcon.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        
        headerView.addSubview(voteLabel)
        voteLabel.anchor(nil, left: voteIcon.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 14)
        voteLabel.centerYAnchor.constraint(equalTo: voteIcon.centerYAnchor).isActive = true
        
        headerView.addSubview(clockIcon)
        clockIcon.anchor(nil, left: voteLabel.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 16, heightConstant: 16)
        clockIcon.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        
        headerView.addSubview(timeLabel)
        timeLabel.anchor(nil, left: clockIcon.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 14)
        timeLabel.centerYAnchor.constraint(equalTo: clockIcon.centerYAnchor).isActive = true
        timeLabel.sizeToFit()
        
        bottomContainerView.addSubview(followIcon)
        followIcon.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor).isActive = true
        followIcon.leftAnchor.constraint(equalTo: centerXAnchor, constant: 20).isActive = true
        followIcon.widthAnchor.constraint(equalToConstant: 14).isActive = true
        followIcon.heightAnchor.constraint(equalToConstant: 14).isActive = true

        bottomContainerView.addSubview(followLabel)
        followLabel.anchorCenterYToSuperview(constant: 1)
        followLabel.anchor(nil, left: followIcon.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 75, heightConstant: 14)
        
        bottomContainerView.addSubview(commentLabel)
        commentLabel.anchorCenterYToSuperview(constant: 1)
        commentLabel.anchor(nil, left: nil, bottom: nil, right: bottomContainerView.centerXAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 75, heightConstant: 14)
        
        bottomContainerView.addSubview(commentIcon)
        commentIcon.anchorCenterYToSuperview()
        commentIcon.anchor(nil, left: nil, bottom: nil, right: commentLabel.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 14, heightConstant: 14)
//
//        bottomContainerView.addSubview(commentIcon)
//        commentIcon.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor).isActive = true
//        commentIcon.rightAnchor.constraint(equalTo: commentLabel.leftAnchor, constant: -10).isActive = true
//        commentIcon.widthAnchor.constraint(equalToConstant: 14).isActive = true
//        commentIcon.heightAnchor.constraint(equalToConstant: 14).isActive = true

    }
}
