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
    
    let optionAView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 91/255, green: 183/255, blue: 242/255, alpha: 1)
        return view
    }()
    
    let optionBView: UIView = {
        let view = UIView()
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
        button.setTitle("What should I eat for lunch?", for: .normal)
        button.setTitleColor(UIColor(red: 61/255, green: 62/255, blue: 68/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
        return button
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "iosuser"
        label.textColor = UIColor(red: 61/255, green: 62/255, blue: 68/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        return label
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "6 comments"
        label.textColor = UIColor(red: 61/255, green: 62/255, blue: 68/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let followLabel: UILabel = {
        let label = UILabel()
        label.text = "follow"
        label.textColor = UIColor(red: 61/255, green: 62/255, blue: 68/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        titleButton.anchor(headerView.topAnchor, left: headerView.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 38, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        titleButton.sizeToFit()
        
        headerView.addSubview(usernameLabel)
        usernameLabel.anchor(titleButton.bottomAnchor, left: headerView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 38, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        usernameLabel.sizeToFit()
        
        bottomContainerView.addSubview(followLabel)
        followLabel.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor).isActive = true
        followLabel.leftAnchor.constraint(equalTo: centerXAnchor, constant: 20).isActive = true
        followLabel.sizeToFit()
        
        bottomContainerView.addSubview(commentLabel)
        commentLabel.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor).isActive = true
        commentLabel.rightAnchor.constraint(equalTo: centerXAnchor, constant: -20).isActive = true
        commentLabel.sizeToFit()
    }
}
