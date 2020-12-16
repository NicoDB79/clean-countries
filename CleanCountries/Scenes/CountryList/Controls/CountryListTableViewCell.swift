//
//  CountryListTableViewCell.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 12/12/2020.
//

import UIKit

class CountryListTableViewCell: UITableViewCell {

    // MARK: - Controls
    
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
}

extension CountryListTableViewCell {
    func bind(_ model: CountryListModels.DisplayedCountry) {
        nameLabel.text = model.name
        let url = (model.imageUrl != nil ? URL(string: model.imageUrl!) : nil)
        flagImageView.downloadImage(with: url)
    }
}
