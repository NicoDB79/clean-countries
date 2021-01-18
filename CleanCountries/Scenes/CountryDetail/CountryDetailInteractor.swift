//
//  CountryDetailInteractor.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 18/01/2021.
//  
//

import Foundation

class CountryDetailInteractor {

    // MARK: Properties
    var presenter: CountryDetailPresenterProtocol?
    private let countriesWorker = CountriesWorker(store: CountriesStoreDatabase())
}

extension CountryDetailInteractor: CountryDetailInteractorProtocol {
    func fetchCountry(for request: CountryDetailModels.FetchRequest) {
        self.presenter?.presentFetchedCountry(for: CountryDetailModels.Response(country: request.country))
    }
}
