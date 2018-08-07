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
    
    let popularHighlightView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor(red: 252/255, green: 185/255, blue: 44/255, alpha: 1).cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    func setupViews() {
        backgroundColor = UIColor.clear
        addSubview(popularView)
        popularView.anchor(nil, left: nil, bottom: nil, right: centerXAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 30)
        popularView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        popularView.addSubview(popularLabel)
        popularLabel.anchor(nil, left: popularView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        popularLabel.centerYAnchor.constraint(equalTo: popularView.centerYAnchor).isActive = true
        popularLabel.sizeToFit()
        
        addSubview(mostRecentView)
        mostRecentView.anchor(nil, left: centerXAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 120, heightConstant: 30)
        mostRecentView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        mostRecentView.addSubview(mostRecentLabel)
        mostRecentLabel.anchor(nil, left: nil, bottom: nil, right: mostRecentView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        mostRecentLabel.centerYAnchor.constraint(equalTo: mostRecentView.centerYAnchor).isActive = true
        mostRecentLabel.sizeToFit()
        
        addSubview(popularHighlightView)
        popularHighlightView.anchor(nil, left: popularView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 120, heightConstant: 40)
        popularHighlightView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
