//
//  CountryDetailInteractor.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 13/12/2020.
//

import Foundation

class CountryDetailInteractor {
    private let presenter: CountryDetailPresentable
    private let countriesWorker = CountriesWorker(store: CountriesStoreDatabase())
    
    init(presenter: CountryDetailPresentable) {
        self.presenter = presenter
    }
}

extension CountryDetailInteractor: CountryDetailBusinessLogic {
    func fetchCountry(for request: CountryDetailModels.FetchRequest) {
        self.presenter.presentFetchedCountry(for: CountryDetailModels.Response(country: request.country))
    }
}
