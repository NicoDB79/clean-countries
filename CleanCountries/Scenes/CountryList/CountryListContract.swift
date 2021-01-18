//
//  CountryListContract.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 18/01/2021.
//  
//

import Foundation

// MARK: View Protocol
protocol CountryListViewProtocol: class, AppDisplayable {
    func displayFetchedCountries(with viewModel: CountryListModels.ListViewModel)
    func displaySearchedCountries(with viewModel: CountryListModels.ListViewModel)
}

// MARK: Interactor Protocol
protocol CountryListInteractorProtocol {
    var countries: [Country]? { get set }
    func fetchDatabaseCountries(completion: (() -> ())?)
    func fetchOnlineCountries()
    func searchCountries(with request: CountryListModels.SearchRequest)
}

// MARK: Presenter Protocol
protocol CountryListPresenterProtocol {
    func presentFetchedCountries(for response: CountryListModels.Response)
    func presentFetchedCountries(error: DataError)
    
    func presentSearchedCountries(for response: CountryListModels.Response)
    func presentSearchedCountries(error: DataError)
}

// MARK: Router Protocol
protocol CountryListRouterProtocol {
    func showCountry(for country: Country)
}
