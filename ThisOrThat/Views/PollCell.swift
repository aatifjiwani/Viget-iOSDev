//
//  PollCell.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 7/27/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class PollCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = UIColor.green
    }
}
