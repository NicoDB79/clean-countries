//
//  AppDisplayable.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 29/10/2020.
//

import UIKit

protocol AppDisplayable {
    func display(error: AppModels.Error, completion: (() -> ())?)
}

extension AppDisplayable where Self: UIViewController {
    
    func display(error: AppModels.Error, completion: (() -> ())?) {
        let alertController = UIAlertController(
            title: error.title,
            message: error.message,
            preferredStyle: .alert
        )
        
        alertController.addAction(
            UIAlertAction(title: "OK", style: .default, handler: { action in
                completion?()
            })
        )
  
        DispatchQueue.main.async {
            guard let topController = UIApplication.topViewController() else { return }
            topController.present(alertController, animated: true, completion: nil)
        }
    }
}
