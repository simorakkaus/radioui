//
//  GenresCell.swift
//  RadioUI
//
//  Created by Simo on 07.04.17.
//  Copyright © 2017 Simo. All rights reserved.
//

import UIKit

class StationCell: UITableViewCell {
    @IBOutlet weak var stationLabel: UILabel!
    @IBOutlet weak var onAirLabel: UILabel!
    @IBOutlet weak var freeTimeStationView: UIView!
    @IBOutlet weak var freeStationLockedView: UIView!
    @IBOutlet weak var addedToFavStationView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
