//
//  CountryListPresenter.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 18/01/2021.
//  
//

import Foundation

class CountryListPresenter {

    // MARK: Properties
    weak var viewController: CountryListViewProtocol?
}

extension CountryListPresenter: CountryListPresenterProtocol {
    func presentFetchedCountries(for response: CountryListModels.Response) {
        let viewModel = CountryListModels.ListViewModel(
            displayedCountries: response.countries.map { make(country: $0) }
        )
        viewController?.displayFetchedCountries(with: viewModel)
    }
    
    func presentFetchedCountries(error: DataError) {
        // Handle and parse error
        let viewModel = AppModels.Error(
            title: "country_list_error_title".localized,
            message: "\("country_list_error_message".localized): \(error.localizedDescription)"
        )
        viewController?.display(error: viewModel, completion: nil)
    }
    
    func presentSearchedCountries(for response: CountryListModels.Response) {
        let viewModel = CountryListModels.ListViewModel(
            displayedCountries: response.countries.map { make(country: $0) }
        )
        viewController?.displaySearchedCountries(with: viewModel)
    }
    
    func presentSearchedCountries(error: DataError) {
        // Handle and parse error
        let viewModel = AppModels.Error(
            title: "country_list_error_title".localized,
            message: "\("country_list_error_message".localized): \(error.localizedDescription)"
        )
        viewController?.display(error: viewModel, completion: nil)
    }
}

// MARK: - Helpers

private extension CountryListPresenter {

    func make(country: Country) -> CountryListModels.DisplayedCountry {
        return CountryListModels.DisplayedCountry(
            id: country.id,
            name: country.name,
            imageUrl: country.flag
        )
    }
}
