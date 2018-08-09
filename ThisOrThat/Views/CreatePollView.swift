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
    
    let uploadAView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(red: 91/255, green: 183/255, blue: 242/255, alpha: 1)
        return view
    }()
    
    let uploadBView: UIImageView = {
        let view = UIImageView()
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
    

    
    func setupViews() {
        addSubview(cancelView)
        cancelView.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 100, heightConstant: 30)
        
        cancelView.addSubview(cancelButton)
        cancelButton.anchor(cancelView.topAnchor, left: nil, bottom: nil, right: cancelView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 19, heightConstant: 19)
        
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
        addSubview(uploadBView)
        uploadBView.anchor(uploadAView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 180)
        
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
        
    }
}
