//
//  CountryDetailRouter.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 13/12/2020.
//

import UIKit

struct CountryDetailRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension CountryDetailRouter: CountryDetailRoutable {
    func showNote(for country: Country) {
        present(storyboard: .countryList,
                identifier: "addNote",
                animated: true,
                modalPresentationStyle: .automatic,
                modalTransitionStyle: .coverVertical,
                configure: { (controller: AddNoteViewController) in
                    controller.country = country
                    controller.onSave = { country in
                        (self.viewController as! CountryDetailViewController).country = country
                        (self.viewController as! CountryDetailViewController).fetchData()
                    }
                },
                completion: nil)
    }
}
