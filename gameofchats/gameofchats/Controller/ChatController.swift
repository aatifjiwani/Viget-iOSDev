//
//  ChatController.swift
//  gameofchats
//
//  Created by Aatif Jiwani on 7/13/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit
import Firebase

class ChatController: UICollectionViewController, UITextFieldDelegate {
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = user?.name
        collectionView?.backgroundColor = UIColor.white
        setupInputViews()
    }
    
    lazy var inputTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Enter message"
        field.delegate = self
        return field
    }()
    
    func setupInputViews() {
        let containerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
//            view.backgroundColor = UIColor.red
            return view
        }()
        
        view.addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let sendButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Send", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        view.addSubview(sendButton)
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        
        view.addSubview(inputTextField)
        inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        let divider = UIView()
        divider.backgroundColor = UIColor.lightGray
        divider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(divider)
        divider.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        divider.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        divider.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
    }
    
    @objc func sendMessage() {
        if let message = inputTextField.text {
            let reference = Database.database().reference().child("messages")
            let child = reference.childByAutoId()
            
            let toID = user!.id!
            let fromID = Auth.auth().currentUser?.uid
            let timestamp = NSNumber(value: Int(NSDate().timeIntervalSince1970))
            let value = ["text":message, "toID": toID, "fromID": fromID!, "timestamp": timestamp] as [String : Any]
            
            child.updateChildValues(value) { (error, dbref) in
                if error != nil {
                    print(error!)
                    return
                }
                
                let refUserMessage = Database.database().reference().child("user-messages").child(fromID!)
                let messageID = child.key
                let values = [messageID: 1]
                
                refUserMessage.updateChildValues(values)
                
                let refRecipMessage = Database.database().reference().child("user-messages").child(toID)
                refRecipMessage.updateChildValues(values)
                
                self.inputTextField.text = ""
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
}



