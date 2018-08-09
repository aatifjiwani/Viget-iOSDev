//
//  CreatePollView.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 8/9/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class CreatePollView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cancelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let cancelLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Cancel"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "cancel"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupViews() {
        addSubview(cancelView)
        cancelView.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 100, heightConstant: 30)
        
        cancelView.addSubview(cancelButton)
        cancelButton.anchor(cancelView.topAnchor, left: nil, bottom: nil, right: cancelView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 19, heightConstant: 19)
    }
}
