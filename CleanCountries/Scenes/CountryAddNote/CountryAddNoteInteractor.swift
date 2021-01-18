//
//  CountryAddNoteInteractor.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 18/01/2021.
//  
//

import Foundation

class CountryAddNoteInteractor {

    // MARK: Properties
    var presenter: CountryAddNotePresenterProtocol?
    private let countriesWorker = CountriesWorker(store: CountriesStoreDatabase())
}

extension CountryAddNoteInteractor: CountryAddNoteInteractorProtocol {
    func fetchNote(for request: CountryAddNoteModels.FetchRequest) {
        let response = CountryAddNoteModels.Response(note: request.country.note)
        presenter?.presentNote(for: response)
    }
    
    func saveNote(_ note: String, for countryID: String) -> Country? {
        let result = countriesWorker.updateNote(note, for: countryID)
        guard let _ = result.value, result.isSuccess else {
            presenter?.presentNote(error: result.error ?? .databaseFailure(nil))
            return nil
        }
        NotificationCenter.default.post(name: .countryUpdated, object: nil)
        return result.value
    }
}
