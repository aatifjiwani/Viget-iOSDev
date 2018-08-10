//
//  UITextFeildExtensions.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 8/10/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func loadDropdownData(min: Int, max: Int, step: Int) {
        var data = [String]()
        
        for index in stride(from: min, through: max, by: step) {
            data.append("\(index)")
        }
        
        self.inputView = NumberPickerView(pickerData: data, dropdownField: self)
    }
}
