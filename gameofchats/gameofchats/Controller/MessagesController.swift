//
//  ViewController.swift
//  gameofchats
//
//  Created by Aatif Jiwani on 7/11/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController {

    var messages = [Message]()
    var messagesDictionary = [String: Message]()
    let messageID = "messageID"
    
    override func viewDidLoad() {
        //let ref = Database.database().reference(fromURL: "https://viget-chat.firebaseio.com/")
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "new_message_icon"), style: .plain, target: self, action: #selector(handleNewMessage))
        tableView.register(UserCell.self, forCellReuseIdentifier: messageID)
        checkIfUserLoggedIn()
//        observeMessages()
        
    }
    
    func observeUserMessages() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let reference = Database.database().reference().child("user-messages").child(uid)
        reference.observe(.childAdded, with: { (snapshot) in
            let messageID = snapshot.key
            let messageReference = Database.database().reference().child("messages").child(messageID)
            messageReference.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dict = snapshot.value as? [String:Any] {
                    let message = Message()
                    message.setValuesForKeys(dict)
                    //self.messages.append(message)
                    self.messagesDictionary[message.toID!] = message
                    self.messages = Array(self.messagesDictionary.values)
                    self.messages.sort(by: { (m1, m2) -> Bool in
                        return m1.timestamp!.intValue > m2.timestamp!.intValue
                    })
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                
            })
        }, withCancel: nil)
    }
    
    func observeMessages() {
        let reference = Database.database().reference().child("messages")
        reference.observe(.childAdded, with: { (snapshot) in
            if let dict = snapshot.value as? [String:Any] {
                let message = Message()
                message.setValuesForKeys(dict)
                //self.messages.append(message)
                self.messagesDictionary[message.toID!] = message
                self.messages = Array(self.messagesDictionary.values)
                self.messages.sort(by: { (m1, m2) -> Bool in
                    return m1.timestamp!.intValue > m2.timestamp!.intValue
                })
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }, withCancel: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: messageID, for: indexPath) as! UserCell
        let message = messages[indexPath.row]
        cell.message = message
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    @objc func handleNewMessage() {
        let newMessageController = NewMessageController()
        newMessageController.messagesController = self
        present(UINavigationController(rootViewController: newMessageController), animated: true, completion: nil)
    }
    
    func checkIfUserLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            fetchUserAndSetupNavBar()
        }
    }
    
    func fetchUserAndSetupNavBar() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? [String:Any] {
                let user = User()
                user.setValuesForKeys(dict)
                self.setupNavbarWithUser(user: user)
            }
        }, withCancel: nil)
    }
    
    func setupNavbarWithUser(user: User) {
        messages.removeAll()
        messagesDictionary.removeAll()
        tableView.reloadData()
        observeUserMessages()
        
        let titleView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = true
            //view.backgroundColor = UIColor.blue
            return view
        }()
        
        let profileImage: UIImageView = {
            let view = UIImageView()
            if let url = user.profileImg {
                view.loadImagesUsingCacheWithURLString(url: url)
            }
            view.translatesAutoresizingMaskIntoConstraints = false
            view.contentMode = .scaleAspectFill
            view.layer.cornerRadius = 20
            view.layer.masksToBounds = true
            return view
        }()

        let nameLabel: UILabel = {
            let label = UILabel()
            label.text = user.name
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        titleView.addSubview(containerView)
        containerView.addSubview(profileImage)
        containerView.addSubview(nameLabel)
        
        profileImage.leftAnchor.constraint(equalTo: titleView.leftAnchor).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 8).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: titleView.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: profileImage.heightAnchor).isActive = true
        
        containerView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        
        self.navigationItem.titleView = titleView
        titleView.centerXAnchor.constraint(equalTo: (self.navigationController?.navigationBar.centerXAnchor)!).isActive = true
        titleView.topAnchor.constraint(equalTo: (self.navigationController?.navigationBar.topAnchor)!).isActive = true
    }
    
    @objc func showChatController(user: User) {
        let layout = UICollectionViewFlowLayout()
        let chatController = ChatController(collectionViewLayout: layout)
        chatController.user = user
        navigationController?.pushViewController(chatController, animated: true)
    }
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
        } catch let logoutErr {
            print(logoutErr)
        }
        
        let loginController = LoginController()
        loginController.messagesController = self
        present(loginController, animated: true, completion: nil)
    }

}

