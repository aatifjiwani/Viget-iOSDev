//
//  CreateOptionView.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 8/10/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit
import Firebase

class CreateOptionView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var controller: CreatePollController?
    
    let chooseLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose from your device:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "NiveauGroteskBold", size: 14)
        label.textColor = UIColor.white
        return label
    }()
    
    let chooseIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "upload-picture")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let browseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("browse +", for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 91/255, blue: 154/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "NiveauGroteskRegular", size: 14)
        button.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        button.dropShadow(color: UIColor.black, opacity: 0.5, offSet: CGSize(width: 0, height: 1), radius: 2)
        button.layer.cornerRadius = 20
        return button
    }()
    
    let fileNameLabel: UILabel = {
        let label = UILabel()
        label.text = "no file chosen"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "NiveauGroteskLight-Italic", size: 14)
        label.textColor = UIColor.white
        return label
    }()
    
    let urlLabel: UILabel = {
        let label = UILabel()
        label.text = "Or copy and paste a URL"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "NiveauGroteskBold", size: 14)
        label.textColor = UIColor.white
        return label
    }()
    
    let urlField: ModalTextField = {
        let field = ModalTextField()
        field.placeholder = "ex: https://gph.is/1CGO9rU"
        field.font = UIFont.systemFont(ofSize: 14)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = UIColor.white
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.spellCheckingType = .no
        field.layer.cornerRadius = 5
        return field
    }()
    
    var selectedImage: UIImage? {
        didSet {
            fileNameLabel.text = "file chosen"
        }
    }
    
    @objc func handleImage() {
        print("thing")
        controller?.currentUploadView = self
        controller?.handleUploadImage()
    }
    
    func getImageURL(completion: @escaping (String) -> ()) {
        if let toUploadImage = selectedImage {
            uploadImageToStorage(toUploadImage) { (url) in
                completion(url)
            }
        } else {
            completion(urlField.text!)
        }
    }
    
    func uploadImageToStorage(_ image: UIImage, completion: @escaping (String) -> ()) {
        let imageName = NSUUID().uuidString
        let storage = Storage.storage().reference().child("message\(imageName).jpg")
        if let data = UIImageJPEGRepresentation(image, 0.2) {
            storage.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error!)
                    completion("")
                }
                
                storage.downloadURL(completion: { (url, error) in
                    if let downURL = url?.absoluteString {
                        completion(downURL)
                    } else {
                        completion("")
                    }
                })
            }
        }
    }
    
    func setupViews() {
        backgroundColor = UIColor.red
        
        addSubview(chooseIcon)
        chooseIcon.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 15, leftConstant: 30, bottomConstant: 0, rightConstant: 0, widthConstant: 15, heightConstant: 15)
        
        addSubview(chooseLabel)
        chooseLabel.anchor(chooseIcon.topAnchor, left: chooseIcon.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        chooseLabel.sizeToFit()
        
        addSubview(browseButton)
        browseButton.anchor(chooseLabel.bottomAnchor, left: chooseIcon.leftAnchor, bottom: nil, right: nil, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 140, heightConstant: 40)
        browseButton.addTarget(self, action: #selector(handleImage), for: .touchUpInside)
        
        addSubview(fileNameLabel)
        fileNameLabel.anchor(nil, left: browseButton.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        fileNameLabel.centerYAnchor.constraint(equalTo: browseButton.centerYAnchor).isActive = true
        fileNameLabel.sizeToFit()
        
        addSubview(urlLabel)
        urlLabel.anchor(browseButton.bottomAnchor, left: chooseIcon.leftAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        urlLabel.sizeToFit()
        
        addSubview(urlField)
        urlField.anchor(urlLabel.bottomAnchor, left: chooseIcon.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 365, heightConstant: 30)
    }
}
