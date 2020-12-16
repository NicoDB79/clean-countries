//
//  CountryListRouter.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 12/12/2020.
//

import UIKit

struct CountryListRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension CountryListRouter: CountryListRoutable {
    
    func showCountry(for country: Country) {
        show(storyboard: .countryList, identifier: "countryDetail") { (controller: CountryDetailViewController) in
            controller.country = country
        }
    }
}
