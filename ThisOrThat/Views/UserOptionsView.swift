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
    
    let resetPasswordView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    let resetPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Reset Password"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "NiveauGroteskBold", size: 16)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    let logoutView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    let logoutLabel: UILabel = {
        let label = UILabel()
        label.text = "Log Out"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "NiveauGroteskBold", size: 16)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    let dividerLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.darkGray
        return view
    }()
    
    func setupViews() {
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        dropShadow(color: UIColor.black, offSet: .zero, radius: 20)
        layer.cornerRadius = 10
        
        addSubview(resetPasswordView)
        resetPasswordView.anchor(topAnchor, left: leftAnchor, bottom: centerYAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        addSubview(logoutView)
        logoutView.anchor(centerYAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        resetPasswordView.addSubview(resetPasswordLabel)
        resetPasswordLabel.anchorCenterXToSuperview()
        resetPasswordLabel.centerYAnchor.constraint(equalTo: resetPasswordView.centerYAnchor).isActive = true
        resetPasswordLabel.sizeToFit()
        
        logoutView.addSubview(logoutLabel)
        logoutLabel.anchorCenterXToSuperview()
        logoutLabel.centerYAnchor.constraint(equalTo: logoutView.centerYAnchor).isActive = true
        logoutLabel.sizeToFit()
        
        addSubview(dividerLine)
        dividerLine.anchor(nil, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        dividerLine.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dividerLine.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    @objc func handleResetPassword(sender: UITapGestureRecognizer) {
        
    }
    
    @objc func handleLogOut(sender: UITapGestureRecognizer) {
        
    }
}
