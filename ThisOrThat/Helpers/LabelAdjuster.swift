//
//  LabelAdjuster.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 7/27/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class LabelAdjuster {
    static func estimateFrameForText(width: CGFloat, fontSize: CGFloat, text: String) -> CGRect {
        let size = CGSize(width: width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize)], context: nil)
    }
}
