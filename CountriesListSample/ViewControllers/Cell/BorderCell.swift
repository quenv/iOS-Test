//
//  BorderCell.swift
//  CountriesListSample
//
//  Created by admin on 10/26/18.
//  Copyright © 2018 QueNguyen. All rights reserved.
//

import UIKit

class BorderCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var borderNameLabel: UILabel!

    // MARK: - init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
