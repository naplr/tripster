//
//  DayImageViewerTableViewCell.swift
//  tripster
//
//  Created by Napol Rachatasumrit on 6/12/16.
//  Copyright © 2016 Napol Rachatasumrit. All rights reserved.
//

import UIKit

class DayImageViewerTableViewCell: UITableViewCell {

    @IBOutlet weak var numDayLabel: UILabel!
    @IBOutlet weak var totalImageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayImage: UIImageView!
    @IBOutlet weak var dayImageIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
