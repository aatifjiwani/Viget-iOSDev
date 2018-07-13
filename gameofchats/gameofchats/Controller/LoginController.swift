//
//  LoginController.swift
//  gameofchats
//
//  Created by Aatif Jiwani on 7/11/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    var messagesController: MessagesController?

    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let registerButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = UIColor(r: 20, g: 150, b: 187, a: 1)
        view.setTitle("Register", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.addTarget(self, action: #selector(handleLoginOrRegister), for: .touchUpInside)
        return view
    }()
    
    @objc func handleLoginOrRegister() {
        if loginSegmentControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    
    let loginSegmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Login", "Register"])
        control.translatesAutoresizingMaskIntoConstraints = false
        control.tintColor = UIColor.white
        control.selectedSegmentIndex = 1
        control.addTarget(self, action: #selector(handleSegmentControl), for: .valueChanged)
        return control
    }()
    
    let nameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Name"
        field.translatesAutoresizingMaskIntoConstraints = false
        
        return field
    }()
    
    let nameSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220, a: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.translatesAutoresizingMaskIntoConstraints = false
        
        return field
    }()
    
    let emailSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220, a: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.isSecureTextEntry = true
        return field
    }()
    
    let profImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "login_image")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        
        return img
    }()
    
    func handleLogin() {
        guard let email = emailField.text, let password = passwordField.text else {
            print("Form login error")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                print(error!)
                return
            }
            
            self.messagesController?.fetchUserAndSetupNavBar()
//            self.messagesController?.navigationItem.title =
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleRegister() {
        guard let email = emailField.text, let password = passwordField.text, let name = nameField.text else {
            print("Form login error")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: {
            (authResult, error) in
            if error != nil {
                print(error!)
                return
            }
            
            guard let uid = authResult?.user.uid else {
                return
            }
            
            self.storeImageIntoStorage(uid: uid, email: email, name: name)
            
            //successfully auth user
        })
        print("Registering User")
    }
    
    private func storeImageIntoStorage(uid: String, email: String, name: String) {
        let storageReference = Storage.storage().reference().child("profileImages").child("profilefor\(uid).jpg")
        if let profileImage = self.profImage.image, let image = UIImageJPEGRepresentation(profileImage, 0.1) {
            storageReference.putData(image, metadata: nil, completion: { (metadata, error) in
                guard let metadata = metadata else {
                    return
                }
                print(metadata)
                //let size = metadata.size
                // You can also access to download URL after upload.
                storageReference.downloadURL { (url, error) in
                    if let urlText = url?.absoluteString {
                        
                        let strURL = urlText
                        print("///////////tttttttt//////// \(strURL)   ////////")
                        
                        DispatchQueue.main.async(execute: {
                            print("something")
                            let values = ["name": name, "email": email, "profileImg": strURL ]
                            self.registerUserIntoDB(uid: uid, values: values)
                        })
                    }
                }
            })
        }
    }
    
    private func registerUserIntoDB(uid: String, values: [String: String]) {
        let ref = Database.database().reference()
        let userNode = ref.child("users").child(uid)
        //
        userNode.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil {
                print(err!)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
//            self.messagesController?.fetchUserAndSetupNavBar()
            let user = User()
            user.setValuesForKeys(values)
            self.messagesController?.setupNavbarWithUser(user: user)
        })
    }
    
    @objc func handleSegmentControl() {
        let title = loginSegmentControl.titleForSegment(at: loginSegmentControl.selectedSegmentIndex)
        registerButton.setTitle(title, for: .normal)
        
        
        inputContainerViewHeightAnchor?.constant = loginSegmentControl.selectedSegmentIndex == 0 ? 100 : 150
        
        nameHeightAnchor?.isActive = false
        nameHeightAnchor = nameField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginSegmentControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameHeightAnchor?.isActive = true
        
        emailHeightAnchor?.isActive = false
        emailHeightAnchor = emailField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginSegmentControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailHeightAnchor?.isActive = true
        
        passwordHeightAnchor?.isActive = false
        passwordHeightAnchor = passwordField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginSegmentControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordHeightAnchor?.isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(r: 9, g: 47, b: 64, a: 1)
        
        view.addSubview(inputsContainerView)
        view.addSubview(registerButton)
        view.addSubview(profImage)
        view.addSubview(loginSegmentControl)
        
        profImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImage))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        
        profImage.addGestureRecognizer(gesture)
        
        setupInputsContainerView()
        setupRegisterButton()
        setupProfImage()
        setupLoginSegmentControl()
        // Do any additional setup after loading the view.
    }
    
    func setupLoginSegmentControl() {
        loginSegmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginSegmentControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginSegmentControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginSegmentControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupProfImage() {
        profImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profImage.bottomAnchor.constraint(equalTo: loginSegmentControl.topAnchor, constant: -12).isActive = true
        profImage.widthAnchor.constraint(equalToConstant: 300).isActive = true
        profImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setupRegisterButton() {
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        registerButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    var inputContainerViewHeightAnchor: NSLayoutConstraint?
    var nameHeightAnchor: NSLayoutConstraint?
    var emailHeightAnchor: NSLayoutConstraint?
    var passwordHeightAnchor: NSLayoutConstraint?
    
    func setupInputsContainerView() {
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputContainerViewHeightAnchor?.isActive = true
        
        inputsContainerView.addSubview(nameField)
        nameField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameHeightAnchor = nameField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameHeightAnchor?.isActive = true
        
        inputsContainerView.addSubview(nameSeparator)
        nameSeparator.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparator.topAnchor.constraint(equalTo: nameField.bottomAnchor).isActive = true
        nameSeparator.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(emailField)
        emailField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor).isActive = true
        emailField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailHeightAnchor = emailField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailHeightAnchor?.isActive = true
        
        inputsContainerView.addSubview(emailSeparator)
        emailSeparator.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparator.topAnchor.constraint(equalTo: emailField.bottomAnchor).isActive = true
        emailSeparator.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        inputsContainerView.addSubview(passwordField)
        passwordField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor).isActive = true
        passwordField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordHeightAnchor = passwordField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordHeightAnchor?.isActive = true
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
