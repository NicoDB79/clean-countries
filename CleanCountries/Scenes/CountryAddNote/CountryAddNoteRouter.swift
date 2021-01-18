//
//  CountryAddNoteRouter.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 18/01/2021.
//  
//

import Foundation
import UIKit

class CountryAddNoteRouter {

    // MARK: Properties
    weak var view: UIViewController?
    
    // MARK: Static methods
    static func createModule() -> CountryAddNoteViewController {
        
        //MARK: Initialise components.
        let viewController = CountryAddNoteViewController.instantiate(storyboardName: "CountryList")
        let presenter = CountryAddNotePresenter()
        let interactor = CountryAddNoteInteractor()
        let router = CountryAddNoteRouter()
        
        //MARK: link VIP components.
        viewController.interactor = interactor
        viewController.router = router
        presenter.viewController = viewController
        interactor.presenter = presenter
        router.view = viewController
        
        return viewController
    }
}

extension CountryAddNoteRouter: CountryAddNoteRouterProtocol {
    func close() {
        view?.dismiss(animated: true, completion: nil)
    }
}
