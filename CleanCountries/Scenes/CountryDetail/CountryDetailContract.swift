//
//  CountryDetailContract.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 18/01/2021.
//  
//

import Foundation

// MARK: View Protocol
protocol CountryDetailViewProtocol: class, AppDisplayable {
    func displayCountry(with viewModel: CountryDetailModels.CountryViewModel)
}

// MARK: Interactor Protocol
protocol CountryDetailInteractorProtocol {
    func fetchCountry(for request: CountryDetailModels.FetchRequest)
}

// MARK: Presenter Protocol
protocol CountryDetailPresenterProtocol {
    func presentFetchedCountry(for response: CountryDetailModels.Response)
    func presentFetchedCountry(error: DataError)
}

// MARK: Router Protocol
protocol CountryDetailRouterProtocol {
    func showNote(for country: Country)
}
