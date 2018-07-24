//
//  ModalTextField.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 7/23/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class ModalTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5);
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        layer.borderColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
        layer.borderWidth = 1
        autocorrectionType = .no
        autocapitalizationType = .none
        spellCheckingType = .no
    }
}
