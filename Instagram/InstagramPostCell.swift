//
//  InstagramPostCell.swift
//  Instagram
//
//  Created by Richard Du on 2/18/17.
//  Copyright © 2017 Richard Du. All rights reserved.
//

import UIKit

class InstagramPostCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
