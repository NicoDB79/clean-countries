//
//  CountryDetailInterfaces.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 13/12/2020.
//

protocol CountryDetailDisplayable: class, AppDisplayable { // View Controller
    func displayCountry(with viewModel: CountryDetailModels.CountryViewModel)
}

protocol CountryDetailBusinessLogic { // Interactor
    func fetchCountry(for request: CountryDetailModels.FetchRequest)
}

protocol CountryDetailPresentable { // Presenter
    func presentFetchedCountry(for response: CountryDetailModels.Response)
    func presentFetchedCountry(error: DataError)
}

protocol CountryDetailRoutable: AppRoutable { // Router
    func showNote(for country: Country)
}
