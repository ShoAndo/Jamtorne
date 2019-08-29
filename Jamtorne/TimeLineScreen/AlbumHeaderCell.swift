//
//  AlbumHeaderCell.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/08/28.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit

class AlbumHeaderCell: UITableViewCell {

    @IBOutlet weak var thubmnailView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
