//
//  ChatController.swift
//  gameofchats
//
//  Created by Aatif Jiwani on 7/13/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit
import Firebase

class ChatController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    var user: User? {
        didSet {
            navigationItem.title = user?.name
            observeMessages()
        }
    }
    
    var messages = [Message]()
    
    private let messageID = "messageID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: messageID)
        collectionView?.alwaysBounceVertical = true
        collectionView?.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
//        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 8, left: 0, bottom: 58, right: 0)
        collectionView?.keyboardDismissMode = .interactive
//        setupInputViews()
//        setupKeyBoards()
    }
    
    let containerView = UIView()
    let send = UIButton(type: .system)
    let divide = UIView()
    
    override var inputAccessoryView: UIView? {
        get {
            containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
            containerView.backgroundColor = UIColor.white
        
            send.setTitle("Send", for: .normal)
            send.translatesAutoresizingMaskIntoConstraints = false

            containerView.addSubview(send)
            send.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
            send.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            send.widthAnchor.constraint(equalToConstant: 80).isActive = true
            send.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
            
            containerView.addSubview(self.inputTextField)
            self.inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
            self.inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            self.inputTextField.rightAnchor.constraint(equalTo: send.leftAnchor).isActive = true
            self.inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
            
            divide.backgroundColor = UIColor.lightGray
            divide.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(divide)
            divide.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            divide.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
            divide.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
            divide.heightAnchor.constraint(equalToConstant: 1).isActive = true
            
            send.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
            
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    func setupKeyBoards() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func handleKeyboard(notification: NSNotification) {
        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let duration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        containerBottomAnchor?.constant = -keyboardFrame!.height
        
        UIView.animate(withDuration: duration!) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleKeyboardHide(notification: NSNotification) {
        let duration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        containerBottomAnchor?.constant = 0
        
        UIView.animate(withDuration: duration!) {
            self.view.layoutIfNeeded()
        }    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func observeMessages() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let messagesRef = Database.database().reference().child("user-messages").child(uid).child((user?.id)!)
        messagesRef.observe(.childAdded, with: { (snapshot) in
            let ref = Database.database().reference().child("messages").child(snapshot.key)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? [String: Any] else {
                    return
                }
                
                let message = Message()
                message.setValuesForKeys(dictionary)
                self.messages.append(message)
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
            }, withCancel: nil)
        }, withCancel: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let message = messages[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: messageID, for: indexPath) as! MessageCell
        setupCell(cell: cell, message: message)
        return cell
    }
    
    private func setupCell(cell: MessageCell, message: Message) {
        cell.textView.text = message.text
        if let url = user?.profileImg {
            cell.profileImage.loadImagesUsingCacheWithURLString(url: url)
        }
        
        if message.fromID == Auth.auth().currentUser?.uid {
            cell.bubbleView.backgroundColor = UIColor(r: 0, g: 137, b: 249, a: 1)
            cell.textView.textColor = UIColor.white
            cell.bubbleRightAnchor?.isActive = true
            cell.bubbleLeftAnchor?.isActive = false
            cell.profileImage.isHidden = true
        } else {
            cell.bubbleView.backgroundColor = UIColor(r: 240, g: 240, b: 240, a: 1)
            cell.textView.textColor = UIColor.black
            cell.bubbleRightAnchor?.isActive = false
            cell.profileImage.isHidden = false
            cell.bubbleLeftAnchor?.isActive = true
        }
        
        cell.bubbleAnchor?.constant = estimateFrameForText(message.text!).width + 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var h: CGFloat = 80
        if let text = messages[indexPath.item].text {
            h = estimateFrameForText(text).height
            
        }
        return CGSize(width: view.frame.width, height: h + 20)
    }
    
    private func estimateFrameForText(_ text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
    lazy var inputTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Enter message"
        field.delegate = self
        return field
    }()
    
    var containerBottomAnchor: NSLayoutConstraint?
    
    func setupInputViews() {
        let containerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor.white
//            view.backgroundColor = UIColor.red
            return view
        }()
        
        view.addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        containerBottomAnchor = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        containerBottomAnchor?.isActive = true
        
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
                
                let refUserMessage = Database.database().reference().child("user-messages").child(fromID!).child(toID)
                let messageID = child.key
                let values = [messageID: 1]
                
                refUserMessage.updateChildValues(values)
                
                let refRecipMessage = Database.database().reference().child("user-messages").child(toID).child(fromID!)
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



