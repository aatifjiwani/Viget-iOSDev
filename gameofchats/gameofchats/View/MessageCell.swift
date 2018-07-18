//
//  MessageCell.swift
//  gameofchats
//
//  Created by Aatif Jiwani on 7/17/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    let textView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Some text"
        view.font = UIFont.systemFont(ofSize: 16)
        view.textColor = UIColor.white
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 0, g: 137, b: 249, a: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    let profileImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let messageImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    var bubbleAnchor: NSLayoutConstraint?
    var bubbleRightAnchor: NSLayoutConstraint?
    var bubbleLeftAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bubbleView)
        addSubview(textView)
        addSubview(profileImage)
        
        profileImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 4).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 32).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        bubbleRightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
        bubbleRightAnchor?.isActive = true
        
        bubbleLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 8)
        bubbleLeftAnchor?.isActive = false
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        bubbleAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleAnchor?.isActive = true
        
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        bubbleView.addSubview(messageImage)
        messageImage.leftAnchor.constraint(equalTo: bubbleView.leftAnchor).isActive = true
        messageImage.topAnchor.constraint(equalTo: bubbleView.topAnchor).isActive = true
        messageImage.widthAnchor.constraint(equalTo: bubbleView.widthAnchor).isActive = true
        messageImage.heightAnchor.constraint(equalTo: bubbleView.heightAnchor).isActive = true
        
        textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
//        textView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
