//
//  CreatePollController.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 8/9/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class CreatePollController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupViews()
    }
    
    var indexController: IndexController?
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 1050
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let createPollView = CreatePollView()
    
    func handleDismiss() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false) {}
    }
    
    func handleUploadImage() {
        print("going...")
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: {
            print("finished")
        })
    }
    
    func handleCreatedPoll() {
        indexController?.polls.removeAll()
        indexController?.fetchPolls(filter: indexController?.currentFilter, popular: (indexController?.isOnPopular)!)
        
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false) {}
    }
    
    var currentUploadView: CreateOptionView?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImage: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            print(editedImage.size)
            selectedImage = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            print(originalImage.size)
            selectedImage = originalImage
        }
        
        if selectedImage != nil && currentUploadView != nil{
            currentUploadView?.selectedImage = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        scrollView.addSubview(createPollView)
//        createPollView.anchor(scrollView.topAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1900)
        createPollView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        createPollView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        createPollView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        createPollView.heightAnchor.constraint(equalToConstant: 1050).isActive = true
        createPollView.controller = self
        
    }
}
