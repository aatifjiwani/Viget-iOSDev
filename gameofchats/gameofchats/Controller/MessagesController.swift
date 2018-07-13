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

    override func viewDidLoad() {
        //let ref = Database.database().reference(fromURL: "https://viget-chat.firebaseio.com/")
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "new_message_icon"), style: .plain, target: self, action: #selector(handleNewMessage))
        checkIfUserLoggedIn()
    }
    
    @objc func handleNewMessage() {
        let newMessageController = NewMessageController()
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
                print(snapshot)
            }
        }, withCancel: nil)
    }
    
    func setupNavbarWithUser(user: User) {
        
        let titleView: UIView = {
            let view = UIView()
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
        
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        titleView.addSubview(profileImage)
        titleView.addSubview(nameLabel)
        
        profileImage.leftAnchor.constraint(equalTo: titleView.leftAnchor).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 8).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: titleView.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: profileImage.heightAnchor).isActive = true
        
        navigationItem.titleView = titleView
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

