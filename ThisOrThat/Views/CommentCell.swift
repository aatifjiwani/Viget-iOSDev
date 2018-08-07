//
//  CommentCell.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 8/7/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class CommentCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "username"
        label.textColor = UIColor(red: 61/255, green: 62/255, blue: 68/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "this user decided it would be a great idea to put a lot of comments in this box"
        label.textColor = UIColor(red: 61/255, green: 62/255, blue: 68/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        return label
    }()
    
    func setupViews() {
        backgroundColor = UIColor.red
        
        addSubview(userNameLabel)
        userNameLabel.anchor(nil, left: leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 0)
        userNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        userNameLabel.sizeToFit()
        
        addSubview(commentLabel)
        commentLabel.anchor(nil, left: userNameLabel.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        commentLabel.heightAnchor.constraint(equalTo: heightAnchor)
        commentLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
