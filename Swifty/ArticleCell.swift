//
//  ArticleCell.swift
//  Swifty
//
//  Created by Hunter Whittle on 12/12/14.
//  Copyright (c) 2014 Hunter Whittle. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var theImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.theImageView.layer.cornerRadius = 5.0
        self.theImageView.clipsToBounds = true
    }
    
    
}
