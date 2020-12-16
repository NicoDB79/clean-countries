//
//  AddNoteRouter.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 13/12/2020.
//
import UIKit

struct AddNoteRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension AddNoteRouter: AddNoteRoutable {
    func close() {
        self.viewController?.dismiss(animated: true, completion: nil)
    }
}
