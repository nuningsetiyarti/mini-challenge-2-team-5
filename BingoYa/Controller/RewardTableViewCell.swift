//
//  RewardTableViewCell.swift
//  BingoYa
//
//  Created by Andimas Bagaswara on 29/05/20.
//  Copyright © 2020 Adrian Renaldi. All rights reserved.
//

import UIKit

class RewardTableViewCell: UITableViewCell {

    @IBOutlet weak var rowView: UIView!
    @IBOutlet weak var rewardImage: UIImageView!
    @IBOutlet weak var rewardTitle: UILabel!
    @IBOutlet weak var rewardDescription: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var markImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        rowView.layer.cornerRadius = 15.0
        rowView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        rowView.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
