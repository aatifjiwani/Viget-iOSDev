//
//  CreatePollView.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 8/9/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit
import Firebase

class CreatePollView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var controller: CreatePollController? {
        didSet {
            uploadAView.controller = controller
            uploadBView.controller = controller
        }
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
    
    let createPollLabel: UILabel = {
        let label = UILabel()
        label.text = "Create a poll"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "NiveauGroteskBold", size: 36)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "This Or That can take it from here."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "NiveauGroteskRegular", size: 18)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Give your poll a title"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "NiveauGroteskRegular", size: 14)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    let titleField = ModalTextField()
    
    let uploadLabel: UILabel = {
        let label = UILabel()
        label.text = "Upload Photos (optional)"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "NiveauGroteskRegular", size: 14)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    
    let uploadAView: CreateOptionView = {
        let view = CreateOptionView()
        view.backgroundColor = UIColor(red: 91/255, green: 183/255, blue: 242/255, alpha: 1)
        return view
    }()
    
    let uploadBView: CreateOptionView = {
        let view = CreateOptionView()
        view.backgroundColor = UIColor(red: 252/255, green: 185/255, blue: 44/255, alpha: 1)
        return view
    }()
    
    let optionALabel: UILabel = {
        let label = UILabel()
        label.text = "Option A"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "NiveauGroteskRegular", size: 14)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    let optionAField = ModalTextField()
    
    let optionBLabel: UILabel = {
        let label = UILabel()
        label.text = "Option B"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "NiveauGroteskRegular", size: 14)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    let optionBField = ModalTextField()
    
    let expireLabel: UILabel = {
        let label = UILabel()
        label.text = "Allow others to vote for:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "NiveauGroteskRegular", size: 14)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    let expireDayField = ModalTextField()
    let expireHourField = ModalTextField()
    let expireMinField = ModalTextField()
    
    let expireDayLabel: UILabel = {
        let label = UILabel()
        label.text = "days"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "NiveauGroteskLight-Italic", size: 14)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    let expireHourLabel: UILabel = {
        let label = UILabel()
        label.text = "hours"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "NiveauGroteskLight-Italic", size: 14)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    let expireMinLabel: UILabel = {
        let label = UILabel()
        label.text = "mins"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "NiveauGroteskLight-Italic", size: 14)
        label.textColor = UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1)
        return label
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SUBMIT POLL", for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "NiveauGroteskBold", size: 14)
        button.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        button.dropShadow(color: UIColor.black, opacity: 0.5, offSet: CGSize(width: 0, height: 1), radius: 2)
        button.layer.cornerRadius = 17
        return button
    }()
    
    @objc func handleCancel() {
        controller?.handleDismiss()
    }
    
    @objc func handleSubmitPoll() {
        print("submitting poll")
        guard (uploadAView.urlField.text?.isEmpty)! || uploadAView.selectedImage == nil else {
            return
        }
        
        guard (uploadBView.urlField.text?.isEmpty)! || uploadBView.selectedImage == nil else {
            return
        }
        
        guard (titleField.text?.count)! >= 10 && (titleField.text?.count)! < 30 else {
            return
        }
        
        guard (optionAField.text?.count)! >= 1 && (optionBField.text?.count)! < 25 else {
            return
        }
        
        guard (optionBField.text?.count)! >= 1 && (optionBField.text?.count)! < 25 else {
            return
        }
        
        
        //var data = ["title": titleField.text, "option_a_url": ""]
    }
    
    func setupViews() {
        addSubview(cancelView)
        cancelView.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 100, heightConstant: 30)
        let cancelTap = UITapGestureRecognizer(target: self, action: #selector(handleCancel))
        cancelView.isUserInteractionEnabled = true
        cancelView.addGestureRecognizer(cancelTap)
        
        cancelView.addSubview(cancelButton)
        cancelButton.anchor(cancelView.topAnchor, left: nil, bottom: nil, right: cancelView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 19, heightConstant: 19)
        cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        
        cancelView.addSubview(cancelLabel)
        cancelLabel.anchor(nil, left: nil, bottom: nil, right: cancelButton.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        cancelLabel.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor).isActive = true
        cancelLabel.sizeToFit()
        
        addSubview(createPollLabel)
        createPollLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 55, leftConstant: 26, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        createPollLabel.sizeToFit()
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(createPollLabel.bottomAnchor, left: createPollLabel.leftAnchor, bottom: nil, right: nil, topConstant: 14, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        descriptionLabel.sizeToFit()
        
        addSubview(titleLabel)
        titleLabel.anchor(descriptionLabel.bottomAnchor, left: createPollLabel.leftAnchor, bottom: nil, right: nil, topConstant: 35, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        titleLabel.sizeToFit()
        
        addSubview(titleField)
        titleField.anchor(titleLabel.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 365, heightConstant: 30)
        titleField.anchorCenterXToSuperview()
        titleField.placeholder = "ex: Should I Buy This or That?"
        titleField.font = UIFont.systemFont(ofSize: 14)
        titleField.layer.cornerRadius = 5
        
        addSubview(uploadLabel)
        uploadLabel.anchor(titleField.bottomAnchor, left: createPollLabel.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        uploadLabel.sizeToFit()
        
        addSubview(uploadAView)
        uploadAView.anchor(uploadLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 180)
        uploadAView.controller = controller
        addSubview(uploadBView)
        uploadBView.anchor(uploadAView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 180)
        uploadBView.controller = controller

        
        addSubview(optionALabel)
        optionALabel.anchor(uploadBView.bottomAnchor, left: createPollLabel.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        optionALabel.sizeToFit()
        
        addSubview(optionAField)
        optionAField.anchor(optionALabel.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 365, heightConstant: 30)
        optionAField.anchorCenterXToSuperview()
        optionAField.placeholder = "ex: Tacos"
        optionAField.font = UIFont.systemFont(ofSize: 14)
        optionAField.backgroundColor = UIColor(red: 182/255, green: 225/255, blue: 252/255, alpha: 1)
        optionAField.layer.cornerRadius = 5
        
        addSubview(optionBLabel)
        optionBLabel.anchor(optionAField.bottomAnchor, left: createPollLabel.leftAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        optionBLabel.sizeToFit()
        
        addSubview(optionBField)
        optionBField.anchor(optionBLabel.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 365, heightConstant: 30)
        optionBField.anchorCenterXToSuperview()
        optionBField.placeholder = "ex: Pizza"
        optionBField.font = UIFont.systemFont(ofSize: 14)
        optionBField.backgroundColor = UIColor(red: 252/255, green: 233/255, blue: 182/255, alpha: 1)
        optionBField.layer.cornerRadius = 5
        
        addSubview(expireLabel)
        expireLabel.anchor(optionBField.bottomAnchor, left: createPollLabel.leftAnchor, bottom: nil, right: nil, topConstant: 40, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        expireLabel.sizeToFit()
        
        addSubview(expireDayField)
        expireDayField.anchor(expireLabel.bottomAnchor, left: createPollLabel.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 30)
        expireDayField.loadDropdownData(min: 0, max: 99, step: 1)
        expireDayField.font = UIFont.systemFont(ofSize: 14)
        expireDayField.layer.cornerRadius = 5
        expireDayField.textAlignment = .right
        
        addSubview(expireHourField)
        expireHourField.anchor(expireDayField.topAnchor, left: expireDayField.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 25, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 30)
        expireHourField.loadDropdownData(min: 0, max: 24, step: 1)
        expireHourField.font = UIFont.systemFont(ofSize: 14)
        expireHourField.layer.cornerRadius = 5
        expireHourField.textAlignment = .right
        
        addSubview(expireMinField)
        expireMinField.anchor(expireDayField.topAnchor, left: expireHourField.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 25, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 30)
        expireMinField.loadDropdownData(min: 0, max: 60, step: 10)
        expireMinField.font = UIFont.systemFont(ofSize: 14)
        expireMinField.layer.cornerRadius = 5
        expireMinField.textAlignment = .right
        
        addSubview(expireDayLabel)
        expireDayLabel.anchor(expireDayField.bottomAnchor, left: nil, bottom: nil, right: expireDayField.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        expireDayLabel.sizeToFit()
        
        addSubview(expireHourLabel)
        expireHourLabel.anchor(expireDayLabel.topAnchor, left: nil, bottom: nil, right: expireHourField.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        expireHourLabel.sizeToFit()
        
        addSubview(expireMinLabel)
        expireMinLabel.anchor(expireDayLabel.topAnchor, left: nil, bottom: nil, right: expireMinField.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        expireMinLabel.sizeToFit()
        
        addSubview(submitButton)
        submitButton.anchorCenterXToSuperview()
        submitButton.anchor(expireHourLabel.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 45, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 195, heightConstant: 40)
        submitButton.addTarget(self, action: #selector(handleSubmitPoll), for: .touchUpInside)
        
    }
}
