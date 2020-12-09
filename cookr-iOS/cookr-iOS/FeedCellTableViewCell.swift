//
//  FeedCellTableViewCell.swift
//  cookr-iOS
//
//  Created by Johnny on 12/6/20.
//

import UIKit

class FeedCellTableViewCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
