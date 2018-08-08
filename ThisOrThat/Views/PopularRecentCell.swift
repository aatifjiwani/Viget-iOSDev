//
//  PopularRecentCell.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 8/7/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class PopularRecentCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let orangeBorder = UIColor(red: 252/255, green: 185/255, blue: 44/255, alpha: 1).cgColor
    let blueBorder = UIColor(red: 97/255, green: 183/255, blue: 242/255, alpha: 1).cgColor
    
    let popularView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 197/255, green: 229/255, blue: 255/255, alpha: 1)
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return view
    }()
    
    let popularLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    let highlightLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    let mostRecentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255/255, green: 227/255, blue: 175/255, alpha: 1)
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        return view
    }()
    
    let mostRecentLabel: UILabel = {
        let label = UILabel()
        label.text = "Most Recent"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    let highlightView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor(red: 252/255, green: 185/255, blue: 44/255, alpha: 1).cgColor
        view.layer.borderWidth = 5
        return view
    }()
    
    var highlightLeftAnchor: NSLayoutConstraint?
    
    var currentState = "popular"
    
    @objc func handlePopular() {
        if currentState != "popular" {
            highlightLabel.text = "Popular"
            animateHighlightView(fromColor: blueBorder, toColor: orangeBorder, fromRadius: 0, toRadius: 20, anchorConstant: 0)
            currentState = "popular"
        }
    }
    
    @objc func handleRecent() {
        if currentState != "recent" {
            highlightLabel.text = "Most Recent"
            animateHighlightView(fromColor: orangeBorder, toColor: blueBorder, fromRadius: 20, toRadius: 0, anchorConstant: 100)
            currentState = "recent"
        }
    }
    
    func animateHighlightView(fromColor: CGColor, toColor: CGColor, fromRadius: CGFloat, toRadius: CGFloat, anchorConstant: CGFloat) {
        highlightLeftAnchor?.constant = anchorConstant
        UIView.animate(withDuration: 1, animations: {
            self.layoutIfNeeded()
            
            let borderAnimate = CABasicAnimation(keyPath: "borderColor")
            borderAnimate.fromValue = fromColor
            borderAnimate.toValue = toColor
            
            let cornerRadiusAnimate = CABasicAnimation(keyPath: "cornerRadius")
            cornerRadiusAnimate.fromValue = fromRadius
            cornerRadiusAnimate.toValue = toRadius
            
            
            let animationGroup = CAAnimationGroup()
            animationGroup.duration = 1
            animationGroup.repeatCount = 1
            animationGroup.animations = [borderAnimate, cornerRadiusAnimate]
            
            self.highlightView.layer.add(animationGroup, forKey: "borderColor and cornerRadius")
        }) { (bool) in
            self.highlightView.layer.cornerRadius = toRadius
            self.highlightView.layer.borderColor = toColor
        }
    }
    
    func setupViews() {
        backgroundColor = UIColor.clear
        addSubview(popularView)
        popularView.anchor(nil, left: nil, bottom: nil, right: centerXAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 30)
        popularView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        let popularTap = UITapGestureRecognizer(target: self, action: #selector(handlePopular))
        popularView.isUserInteractionEnabled = true
        popularView.addGestureRecognizer(popularTap)
        
        popularView.addSubview(popularLabel)
        popularLabel.anchor(nil, left: popularView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        popularLabel.centerYAnchor.constraint(equalTo: popularView.centerYAnchor).isActive = true
        popularLabel.sizeToFit()
        
        addSubview(mostRecentView)
        mostRecentView.anchor(nil, left: centerXAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 120, heightConstant: 30)
        mostRecentView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        let recentTap = UITapGestureRecognizer(target: self, action: #selector(handleRecent))
        mostRecentView.isUserInteractionEnabled = true
        mostRecentView.addGestureRecognizer(recentTap)
        
        mostRecentView.addSubview(mostRecentLabel)
        mostRecentLabel.anchor(nil, left: nil, bottom: nil, right: mostRecentView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        mostRecentLabel.centerYAnchor.constraint(equalTo: mostRecentView.centerYAnchor).isActive = true
        mostRecentLabel.sizeToFit()
        
        addSubview(highlightView)
        highlightView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 120, heightConstant: 40)
        highlightView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        highlightLeftAnchor = highlightView.leftAnchor.constraint(equalTo: popularView.leftAnchor, constant: 0)
        highlightLeftAnchor?.isActive = true
        
        highlightView.addSubview(highlightLabel)
        highlightLabel.anchorCenterSuperview()
    }
}
