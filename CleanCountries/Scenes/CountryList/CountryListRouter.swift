//
//  CountryListRouter.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 18/01/2021.
//  
//

import Foundation
import UIKit

class CountryListRouter {
    
    // MARK: Properties
    weak var view: UIViewController?
    
    // MARK: Static methods
    static func createModule() -> UINavigationController {
        
        //MARK: Initialise components.
        let viewController = CountryListViewController.instantiate(storyboardName: "CountryList")
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter = CountryListPresenter()
        let interactor = CountryListInteractor()
        let router = CountryListRouter()
        
        //MARK: link VIP components.
        viewController.interactor = interactor
        viewController.router = router
        presenter.viewController = viewController
        interactor.presenter = presenter
        router.view = viewController
        return navigationController
    }
}

extension CountryListRouter: CountryListRouterProtocol {
    func showCountry(for country: Country) {
        let countryDetailVC = CountryDetailRouter.createModule()
        countryDetailVC.country = country
        view?.navigationController?.pushViewController(countryDetailVC, animated: true)
    }
}
