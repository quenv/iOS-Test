//
//  CountryCell.swift
//  CountriesList
//
//  Created by admin on 10/25/18.
//  Copyright © 2018 smartosc. All rights reserved.
//

import UIKit
import SVGKit

class CountryCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    
    // MARK: - Properties
    static let defaultAvatar = UIImage(named: CLString.defaultImageName)

    
    // MARK: - init
    override func awakeFromNib() {
        super.awakeFromNib()
        setOpaqueBackground()
        flagImageView.setRoundedImage(CountryCell.defaultAvatar)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Setup Cell
    func configCell(_ model: CountryViewModel){
        countryNameLabel.text = model.name
    }
    
}

private extension CountryCell {
    static let defaultBackgroundColor = UIColor.groupTableViewBackground
    
    func setOpaqueBackground() {
        alpha = 1.0
        backgroundColor = CountryCell.defaultBackgroundColor
        flagImageView.alpha = 1.0
        flagImageView.backgroundColor = CountryCell.defaultBackgroundColor
    }
}
