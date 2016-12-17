//
//  KwickieCell.swift
//  KwickieTest
//
//  Created by Nishant Shrestha on 15/12/16.
//  Copyright © 2016 Nishant Shrestha. All rights reserved.
//

import UIKit
import Kingfisher

class KwickieCell: UITableViewCell {

    @IBOutlet weak var kwickieUsersLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    // Model associated with the cell
    var kwickie: Kwickie? {
        didSet {
            // Set the labels
            kwickieUsersLabel.attributedText = kwickie?.kwickieUsersAttributedString()
            numberOfLikesLabel.text = kwickie?.likeCountString()
            numberOfCommentsLabel.text = kwickie?.commentCountString()
            createdAtLabel.text = kwickie?.timeSinceCreation()
            
            // Set a different color for Kwickies that the current user has liked.
            if let liked = kwickie?.liked {
                numberOfLikesLabel.textColor = liked ? UIColor("#FF4252") : UIColor("#636370")
            }
            
            // Set the thumbnail image 
            // QUESTION: Should we use thumbTransparentUrl or posterURL
            if let imageURLString = kwickie?.kwickieVideo.thumbTransparentUrl {
                if let thumbImageURL = URL(string: imageURLString), let placeholderImage = UIImage(named: "kwickie-placeholder") {
                    // Set the image
                    thumbnailImageView.kf.setImage(with: thumbImageURL, placeholder: placeholderImage)
                }
            }
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
