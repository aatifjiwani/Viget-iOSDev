//
//  ChatController.swift
//  gameofchats
//
//  Created by Aatif Jiwani on 7/13/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit
import Firebase

class ChatController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        setupKeyBoards()
    }
    
    let containerView = UIView()
    let send = UIButton(type: .system)
    let divide = UIView()
    
    override var inputAccessoryView: UIView? {
        get {
            containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
            containerView.backgroundColor = UIColor.white
            containerView.isMultipleTouchEnabled = true
            containerView.isUserInteractionEnabled = true
            
            let chooseImage = UIImageView()
            chooseImage.image = UIImage(named: "upload_image_icon")
            chooseImage.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(chooseImage)
            
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(handleChatImage))
            chooseImage.isMultipleTouchEnabled = true
            chooseImage.isUserInteractionEnabled = true
            chooseImage.addGestureRecognizer(gesture)
            
            chooseImage.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
            chooseImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            chooseImage.widthAnchor.constraint(equalToConstant: 44).isActive = true
            chooseImage.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
            send.setTitle("Send", for: .normal)
            send.translatesAutoresizingMaskIntoConstraints = false

            containerView.addSubview(send)
            send.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
            send.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            send.widthAnchor.constraint(equalToConstant: 80).isActive = true
            send.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
            
            containerView.addSubview(self.inputTextField)
            self.inputTextField.leftAnchor.constraint(equalTo: chooseImage.rightAnchor, constant: 8).isActive = true
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
    
    @objc func handleChatImage(sender: UIGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImage: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            print(editedImage.size)
            selectedImage = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            print(originalImage.size)
            selectedImage = originalImage
        }
        
        if selectedImage != nil {
           uploadImageToStorage(selectedImage!)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func uploadImageToStorage(_ image: UIImage) {
        let imageName = NSUUID().uuidString
        let storage = Storage.storage().reference().child("messageImages").child("message\(imageName).jpg")
        if let data = UIImageJPEGRepresentation(image, 0.2) {
            storage.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                storage.downloadURL(completion: { (url, error) in
                    if let downURL = url?.absoluteString {
                        self.sendImageWith(downURL, image)
                    }
                })
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    func setupKeyBoards() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    }
    
    @objc func handleKeyboardShow(notification: NSNotification) {
        if messages.count > 0 {
            let path = IndexPath(item: messages.count - 1, section: 0)
            collectionView?.scrollToItem(at: path, at: .top, animated: true)
        }
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
                    let path = IndexPath(item: self.messages.count - 1, section: 0)
                    self.collectionView?.scrollToItem(at: path, at: .bottom, animated: true)
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
        
        if let imageURL = message.imageURL {
            cell.messageImage.loadImagesUsingCacheWithURLString(url: imageURL)
            cell.messageImage.isHidden = false
            cell.bubbleView.backgroundColor = UIColor.clear
        } else {
            cell.messageImage.isHidden = true
            cell.bubbleView.isHidden = false
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
        
        if let txt = message.text {
            cell.bubbleAnchor?.constant = estimateFrameForText(txt).width + 32
        } else if message.imageURL != nil {
            cell.bubbleAnchor?.constant = 200
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var h: CGFloat = 80
        let message = messages[indexPath.item]
        if let text = message.text {
            h = estimateFrameForText(text).height
        } else if let width = message.imageWidth, let height = message.imageHeight {
            let decimal = (height.decimalValue / width.decimalValue) * 200
            let doubleVal = NSDecimalNumber(decimal: decimal).doubleValue
            h = CGFloat(doubleVal)
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
    
    @objc func sendMessage() {
        if let message = inputTextField.text {
            let value = ["text":message] as [String : Any]
            sendMessageWithProperties(value)
        }
    }
    
    func sendImageWith(_ url: String, _ image: UIImage) {
        let value = ["imageURL": url, "imageWidth":image.size.width, "imageHeight": image.size.height] as [String : Any]
        sendMessageWithProperties(value)
    }
    
    func sendMessageWithProperties(_ properties: [String: Any]) {
        let reference = Database.database().reference().child("messages")
        let child = reference.childByAutoId()
        
        let toID = user!.id!
        let fromID = Auth.auth().currentUser?.uid
        let timestamp = NSNumber(value: Int(NSDate().timeIntervalSince1970))
        var value = ["toID": toID, "fromID": fromID!, "timestamp": timestamp] as [String : Any]
        
        properties.forEach { (key, val) in
            value[key] = val
        }
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
}



