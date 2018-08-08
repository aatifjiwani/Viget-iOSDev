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
    
    let lightBlue = UIColor(red: 182/255, green: 225/255, blue: 252/255, alpha: 1)
    let midBlue = UIColor(red: 122/255, green: 204/255, blue: 255/255, alpha: 1)
    let lightOrange = UIColor(red: 252/255, green: 233/255, blue: 182/255, alpha: 1)
    let midOrange = UIColor(red: 255/255, green: 213/255, blue: 122/255, alpha: 1)
    
    var lightColor: CGColor?
    var midColor: CGColor?
    
    var alreadyCreated = false
    
    var whichColor: Bool? {
        didSet {
            if !alreadyCreated {
                if whichColor! {
                    lightColor = lightBlue.cgColor
                    midColor = midBlue.cgColor
                    
                    upperTitleView.backgroundColor = lightBlue
                    usernameLabel.backgroundColor = lightBlue
                    voteLabel.backgroundColor = lightBlue
                    timeLabel.backgroundColor = lightBlue
                    commentLabel.backgroundColor = lightBlue
                    followLabel.backgroundColor = lightBlue
                } else {
                    lightColor = lightOrange.cgColor
                    midColor = midOrange.cgColor
                    
                    upperTitleView.backgroundColor = lightOrange
                    usernameLabel.backgroundColor = lightOrange
                    voteLabel.backgroundColor = lightOrange
                    timeLabel.backgroundColor = lightOrange
                    commentLabel.backgroundColor = lightOrange
                    followLabel.backgroundColor = lightOrange
                }
                
                startAnimation()
                alreadyCreated = true
            }
        }
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
        view.backgroundColor = UIColor(red: 91/255, green: 183/255, blue: 242/255, alpha: 1)
        return view
    }()
    
    let optionBView: UIImageView = {
        let view = UIImageView()
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
        return view
    }()
    
    let upperTitleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 182/255, green: 225/255, blue: 252/255, alpha: 1)
        view.layer.cornerRadius = 11
        return view
    }()
    
    let gradientTitleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.cornerRadius = 11
        view.layer.masksToBounds = true
        return view
    }()
    
    let usernameLabel: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 182/255, green: 225/255, blue: 252/255, alpha: 1)
        view.layer.cornerRadius = 7
        return view
    }()
    
    let gradientUsernameLabel: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 7
        return view
    }()
    
    let commentLabel: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 182/255, green: 225/255, blue: 252/255, alpha: 1)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 7
        return view
    }()
    
    let gradientCommentLabel: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 7
        return view
    }()
    
    let followLabel: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 182/255, green: 225/255, blue: 252/255, alpha: 1)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 7
        return view
    }()
    
    let gradientFollowLabel: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 7
        return view
    }()
    
    let voteLabel: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 182/255, green: 225/255, blue: 252/255, alpha: 1)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 7
        return view
    }()
    
    let gradientVoteLabel: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 7
        return view
    }()
    
    let timeLabel: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 182/255, green: 225/255, blue: 252/255, alpha: 1)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 7
        return view
    }()
    
    let gradientTimeLabel: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
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
        
        headerView.addSubview(upperTitleView)
        upperTitleView.anchor(headerView.topAnchor, left: headerView.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 38, bottomConstant: 0, rightConstant: 0, widthConstant: frame.width / 2, heightConstant: 22)
        
        headerView.addSubview(gradientTitleView)
        gradientTitleView.anchor(upperTitleView.topAnchor, left: upperTitleView.leftAnchor, bottom: upperTitleView.bottomAnchor, right: upperTitleView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        headerView.addSubview(usernameLabel)
        usernameLabel.anchor(upperTitleView.bottomAnchor, left: headerView.leftAnchor, bottom: nil, right: nil, topConstant: 13, leftConstant: 38, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 14)
        headerView.addSubview(gradientUsernameLabel)
        gradientUsernameLabel.anchor(usernameLabel.topAnchor, left: usernameLabel.leftAnchor, bottom: usernameLabel.bottomAnchor, right: usernameLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        headerView.addSubview(voteIcon)
        voteIcon.anchor(nil, left: usernameLabel.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 25, bottomConstant: 0, rightConstant: 0, widthConstant: 16, heightConstant: 16)
        voteIcon.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        
        headerView.addSubview(voteLabel)
        voteLabel.anchor(nil, left: voteIcon.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 14)
        voteLabel.centerYAnchor.constraint(equalTo: voteIcon.centerYAnchor).isActive = true
        headerView.addSubview(gradientVoteLabel)
        gradientVoteLabel.anchor(voteLabel.topAnchor, left: voteLabel.leftAnchor, bottom: voteLabel.bottomAnchor, right: voteLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        headerView.addSubview(clockIcon)
        clockIcon.anchor(nil, left: voteLabel.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 16, heightConstant: 16)
        clockIcon.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        
        headerView.addSubview(timeLabel)
        timeLabel.anchor(nil, left: clockIcon.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 14)
        timeLabel.centerYAnchor.constraint(equalTo: clockIcon.centerYAnchor).isActive = true
        headerView.addSubview(gradientTimeLabel)
        gradientTimeLabel.anchor(timeLabel.topAnchor, left: timeLabel.leftAnchor, bottom: timeLabel.bottomAnchor, right: timeLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        bottomContainerView.addSubview(followIcon)
        followIcon.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor).isActive = true
        followIcon.leftAnchor.constraint(equalTo: centerXAnchor, constant: 20).isActive = true
        followIcon.widthAnchor.constraint(equalToConstant: 14).isActive = true
        followIcon.heightAnchor.constraint(equalToConstant: 14).isActive = true

        bottomContainerView.addSubview(followLabel)
        followLabel.anchorCenterYToSuperview(constant: 1)
        followLabel.anchor(nil, left: followIcon.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 75, heightConstant: 14)
        bottomContainerView.addSubview(gradientFollowLabel)
        gradientFollowLabel.anchor(followLabel.topAnchor, left: followLabel.leftAnchor, bottom: followLabel.bottomAnchor, right: followLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        bottomContainerView.addSubview(commentLabel)
        commentLabel.anchorCenterYToSuperview(constant: 1)
        commentLabel.anchor(nil, left: nil, bottom: nil, right: bottomContainerView.centerXAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 75, heightConstant: 14)
        bottomContainerView.addSubview(gradientCommentLabel)
        gradientCommentLabel.anchor(commentLabel.topAnchor, left: commentLabel.leftAnchor, bottom: commentLabel.bottomAnchor, right: commentLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        bottomContainerView.addSubview(commentIcon)
        commentIcon.anchorCenterYToSuperview()
        commentIcon.anchor(nil, left: nil, bottom: nil, right: commentLabel.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 14, heightConstant: 14)
    }
    
    func startAnimation() {
        
        //Header View gradients
        let titleGradient = createGradient(lowerColor: lightColor!, upperColor: midColor!, frame: CGRect(x: 0, y: -30, width: frame.width, height: 70))
        let usernameGradient = createGradient(lowerColor: lightColor!, upperColor: midColor!, frame: CGRect(x: 0, y: -30, width: frame.width, height: 70))
        let voteGradient = createGradient(lowerColor: lightColor!, upperColor: midColor!, frame: CGRect(x: 0, y: -30, width: frame.width, height: 70))
        let timeGradient = createGradient(lowerColor: lightColor!, upperColor: midColor!, frame: CGRect(x: 0, y: -30, width: frame.width, height: 70))
        
        //Bottom View gradients
        let commentGradient = createGradient(lowerColor: lightColor!, upperColor: midColor!, frame: CGRect(x: 0, y: 55, width: frame.width, height: 80))
        let followGradient = createGradient(lowerColor: lightColor!, upperColor: midColor!, frame: CGRect(x: 0, y: 55, width: frame.width, height: 80))
        
        //Header View labels
        gradientTitleView.layer.insertSublayer(titleGradient, at: 0)
        gradientUsernameLabel.layer.insertSublayer(usernameGradient, at: 0)
        gradientVoteLabel.layer.insertSublayer(voteGradient, at: 0)
        gradientTimeLabel.layer.insertSublayer(timeGradient, at: 0)
        
        //Bottom View labels
        gradientCommentLabel.layer.insertSublayer(commentGradient, at: 0)
        gradientFollowLabel.layer.insertSublayer(followGradient, at: 0)

        
        //Header view animations
        addGradientAnimation(gradient: titleGradient)
        addGradientAnimation(gradient: usernameGradient)
        addGradientAnimation(gradient: voteGradient)
        addGradientAnimation(gradient: timeGradient)
        
        //Bottom View animations
        addGradientAnimation(gradient: commentGradient)
        addGradientAnimation(gradient: followGradient)
    }
    
    func createGradient(lowerColor: CGColor, upperColor: CGColor, frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [lowerColor, upperColor, lowerColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.frame = frame
        
        let angle = 45 * CGFloat.pi / 180
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        return gradientLayer
    }
    
    func addGradientAnimation(gradient: CAGradientLayer) {
        let gradientAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        gradientAnimation.duration = 2
        gradientAnimation.fromValue = -frame.width
        gradientAnimation.toValue = frame.width
        gradientAnimation.repeatCount = Float.infinity
        gradient.add(gradientAnimation, forKey: "headerGradientAnim")
    }
}
