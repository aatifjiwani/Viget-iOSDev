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
        collectionView?.backgroundColor = UIColor.green
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.alwaysBounceVertical = true
        setupViews()
    }
    
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
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red: 91/255, green: 183/255, blue: 242/255, alpha: 1)
        view.layer.cornerRadius = 100
        return view
    }()
    
    let optionBView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red: 252/255, green: 185/255, blue: 44/255, alpha: 1)
        return view
    }()
    
    func setupViews() {
        view.addSubview(pollInfoView)
        pollInfoView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 125, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 350)
        
        view.addSubview(headerContainerView)
        headerContainerView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 125)
        
        headerContainerView.addSubview(titleLabel)
        titleLabel.anchor(nil, left: nil, bottom: headerContainerView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        titleLabel.anchorCenterXToSuperview()
        titleLabel.sizeToFit()
        
        headerContainerView.addSubview(goBackButton)
        goBackButton.anchor(headerContainerView.topAnchor, left: headerContainerView.leftAnchor, bottom: nil, right: nil, topConstant: 25, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        goBackButton.sizeToFit()
        
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
        followLabel.anchor(nil, left: nil, bottom: nil, right: pollInfoView.rightAnchor, topConstant: 25, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        followLabel.centerYAnchor.constraint(equalTo: clockIcon.centerYAnchor).isActive = true
        followLabel.sizeToFit()
        
        pollInfoView.addSubview(followIcon)
        followIcon.anchor(pollInfoView.topAnchor, left: nil, bottom: nil, right: followLabel.leftAnchor, topConstant: 25, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 20, heightConstant: 20)
        
        pollInfoView.addSubview(optionAView)
        optionAView.anchor(voteIcon.bottomAnchor, left: pollInfoView.leftAnchor, bottom: nil, right: nil, topConstant: 35, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: (view.frame.width / 2) - 10, heightConstant: 200)
        
        pollInfoView.addSubview(optionBView)
        optionBView.anchor(voteIcon.bottomAnchor, left: nil, bottom: nil, right: pollInfoView.rightAnchor, topConstant: 35, leftConstant: 0, bottomConstant: 0, rightConstant: 5, widthConstant: (view.frame.width / 2) - 10, heightConstant: 200)
    }
}
