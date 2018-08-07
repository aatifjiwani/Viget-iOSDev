//
//  CommentCell.swift
//  ThisOrThat
//
//  Created by Aatif Jiwani on 8/7/18.
//  Copyright © 2018 Aatif Jiwani. All rights reserved.
//

import UIKit

class CommentCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = UIColor.red
    }
}
