//
//  CountryDetailRouter.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 18/01/2021.
//  
//

import Foundation
import UIKit

class CountryDetailRouter {
    
    // MARK: Properties
    weak var view: UIViewController?
    
    // MARK: Static methods
    static func createModule() -> CountryDetailViewController {
        
        //MARK: Initialise components.
        let viewController = CountryDetailViewController.instantiate(storyboardName: "CountryList")
        let presenter = CountryDetailPresenter()
        let interactor = CountryDetailInteractor()
        let router = CountryDetailRouter()
        
        //MARK: link VIP components.
        viewController.interactor = interactor
        viewController.router = router
        presenter.viewController = viewController
        interactor.presenter = presenter
        router.view = viewController
        
        return viewController
    }
}

extension CountryDetailRouter: CountryDetailRouterProtocol {
    func showNote(for country: Country) {
        let countryAddNoteVC = CountryAddNoteRouter.createModule()
        countryAddNoteVC.country = country
        countryAddNoteVC.onSave = { country in
            (self.view as! CountryDetailViewController).country = country
            (self.view as! CountryDetailViewController).fetchData()
        }
        view?.present(countryAddNoteVC, animated: true, completion: nil)
    }
}
