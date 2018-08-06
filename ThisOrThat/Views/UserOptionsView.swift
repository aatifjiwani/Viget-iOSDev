//
//  UserOptionsView.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 8/6/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class UserOptionsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var indexController: IndexController?
    
    func setupViews() {
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        dropShadow(color: UIColor.black, offSet: .zero, radius: 20)
        layer.cornerRadius = 10
    }
}
