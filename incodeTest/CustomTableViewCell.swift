//
//  CustomTableViewCell.swift
//  incodeTest
//
//  Created by Emmanuel Lopez Guerrero on 7/11/18.
//  Copyright © 2018 Emmanuel Lopez Guerrero. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
