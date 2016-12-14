//
//  KwickieCell.swift
//  KwickieTest
//
//  Created by Nishant Shrestha on 15/12/16.
//  Copyright © 2016 Nishant Shrestha. All rights reserved.
//

import UIKit

class KwickieCell: UITableViewCell {

    @IBOutlet weak var kwickieUsersLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    
    // Model associated with the cell
    var kwickie: Kwickie? {
        didSet {
            numberOfLikesLabel.text = kwickie?.answerUser.firstName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
