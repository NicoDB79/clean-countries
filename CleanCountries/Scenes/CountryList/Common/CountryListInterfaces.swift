//
//  CountryListInterfaces.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 12/12/2020.
//

protocol CountryListDisplayable: class, AppDisplayable { // View Controller
    func displayFetchedCountries(with viewModel: CountryListModels.ListViewModel)
    func displaySearchedCountries(with viewModel: CountryListModels.ListViewModel)
}

protocol CountryListBusinessLogic { // Interactor
    var countries: [Country]? { get set }
    func fetchDatabaseCountries(completion: (() -> ())?)
    func fetchOnlineCountries()
    func searchCountries(with request: CountryListModels.SearchRequest)
}

protocol CountryListPresentable { // Presenter
    func presentFetchedCountries(for response: CountryListModels.Response)
    func presentFetchedCountries(error: DataError)
    
    func presentSearchedCountries(for response: CountryListModels.Response)
    func presentSearchedCountries(error: DataError)
}

protocol CountryListRoutable: AppRoutable { // Router
    func showCountry(for country: Country)
}
