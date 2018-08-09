//
//  CreatePollController.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 8/9/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class CreatePollController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupViews()
    }
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 2000
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let createPollView = CreatePollView()
    
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
        createPollView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
    }
}
