//
//  FavStationCell.swift
//  RadioUI
//
//  Created by Simo on 05.05.17.
//  Copyright © 2017 Simo. All rights reserved.
//

import UIKit

class FavStationCell: UITableViewCell {

    @IBOutlet weak var onAirLabel: UILabel!
    @IBOutlet weak var lockedStation: UIView!
    @IBOutlet weak var tempFreeStation: UIView!
    @IBOutlet weak var favStation: UIView!
    @IBOutlet weak var stationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
