//
//  LoginView.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 7/20/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class SignupView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    var indexController: IndexController?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "SIGN UP"
        label.font = UIFont(name: "NiveauGroteskBold", size: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        return label
    }()
    
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
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    let loginView: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let newHereView: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "USERNAME"
        label.font = UIFont(name: "NiveauGroteskLight-SmallCaps", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "EMAIL"
        label.font = UIFont(name: "NiveauGroteskLight-SmallCaps", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        return label
    }()
    
    let confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "CONFIRM PASSWORD"
        label.font = UIFont(name: "NiveauGroteskLight-SmallCaps", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        return label
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "PASSWORD"
        label.font = UIFont(name: "NiveauGroteskLight-SmallCaps", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        return label
    }()
    
    let usernameField: ModalTextField = {
        let field = ModalTextField()
        field.placeholder = "Maximum 20 characters"
        return field
    }()
    
    let emailField = ModalTextField()
    
    let confirmPasswordField = ModalTextField()
    
    let passwordField: ModalTextField = {
        let field = ModalTextField()
        field.placeholder = "Must have 8 characters"
        return field
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("sign up", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "NiveauGroteskBold", size: 14)
        button.backgroundColor = UIColor(red: 252/255, green: 185/255, blue: 44/255, alpha: 1)
        button.dropShadow(color: UIColor.black, opacity: 1, offSet: .zero, radius: 10)
        button.addTarget(self, action: #selector(sendSignupData), for: .touchUpInside)
        button.layer.cornerRadius = 17
        button.clipsToBounds = true
        return button
    }()
    
    @objc func sendSignupData() {
        guard let username = usernameField.text, let email = emailField.text, let password = passwordField.text, let confPass = confirmPasswordField.text else {
            return
        }
        
        APIServices.signupUser(username: username, email: email, password: password, confPassword: confPass) { (response) in
            print(response)
            if response["status"] as! String == "success" {
                let user = User(json: response)
                UserDefaults.standard.setIsLoggedIn(value: true)
                UserDefaults.standard.setUser(value: user.id!)
                self.indexController?.user = user
                self.indexController?.handleCancelSignup()
                self.indexController?.setupLoggedIn(new: true)
            } else {
                print("error")
            }
        }
    }
    
    func setupViews() {
        
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        dropShadow(color: UIColor.black, offSet: .zero, radius: 20)
        layer.cornerRadius = 10
        
        addSubview(loginLabel)
        loginLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 32, leftConstant: 36, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        loginLabel.sizeToFit()
        
        addSubview(cancelView)
        cancelView.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 17, leftConstant: 0, bottomConstant: 0, rightConstant: 17, widthConstant: 75, heightConstant: 20)
        
        cancelView.addSubview(cancelLabel)
        cancelLabel.anchor(cancelView.topAnchor, left: cancelView.leftAnchor, bottom: nil, right: nil, topConstant: 1.5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        cancelLabel.sizeToFit()
        
        cancelView.addSubview(cancelButton)
        cancelButton.anchor(cancelView.topAnchor, left: nil, bottom: nil, right: cancelView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 19, heightConstant: 19)
        
        addSubview(bottomView)
        bottomView.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 45)
        
        bottomView.addSubview(newHereView)
        newHereView.anchor(bottomView.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        newHereView.anchorCenterXToSuperview(constant: -30)
        newHereView.sizeToFit()
        
        bottomView.addSubview(loginView)
        loginView.titleLabel?.anchor(bottomView.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        loginView.anchorCenterXToSuperview(constant: 77)
        loginView.sizeToFit()
        
        addSubview(emailLabel)
        emailLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 100, leftConstant: 36, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        emailLabel.sizeToFit()
        
        addSubview(emailField)
        emailField.anchorCenterXToSuperview()
        emailField.anchor(emailLabel.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 25, leftConstant: 36, bottomConstant: 0, rightConstant: 36, widthConstant: 0, heightConstant: 30)
        
        addSubview(usernameLabel)
        usernameLabel.anchor(emailField.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 25, leftConstant: 36, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        usernameLabel.sizeToFit()
        
        addSubview(usernameField)
        usernameField.anchorCenterXToSuperview()
        usernameField.anchor(usernameLabel.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 25, leftConstant: 36, bottomConstant: 0, rightConstant: 36, widthConstant: 0, heightConstant: 30)
        
        addSubview(passwordLabel)
        passwordLabel.anchor(usernameField.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 25, leftConstant: 36, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        passwordLabel.sizeToFit()
        
        addSubview(passwordField)
        passwordField.anchorCenterXToSuperview()
        passwordField.anchor(passwordLabel.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 25, leftConstant: 36, bottomConstant: 0, rightConstant: 36, widthConstant: 0, heightConstant: 30)
        
        addSubview(confirmPasswordLabel)
        confirmPasswordLabel.anchor(passwordField.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 25, leftConstant: 36, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        confirmPasswordLabel.sizeToFit()
        
        addSubview(confirmPasswordField)
        confirmPasswordField.anchorCenterXToSuperview()
        confirmPasswordField.anchor(confirmPasswordLabel.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 25, leftConstant: 36, bottomConstant: 0, rightConstant: 36, widthConstant: 0, heightConstant: 30)
        
        
        addSubview(signupButton)
        signupButton.anchorCenterXToSuperview()
        signupButton.anchor(confirmPasswordField.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 120, heightConstant: 34)
    }
    
    
}
