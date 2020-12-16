//
//  AddNoteInteractor.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 13/12/2020.
//
import Foundation

struct AddNoteInteractor {
    private let presenter: AddNotePresentable
    private let countriesWorker = CountriesWorker(store: CountriesStoreDatabase())
    
    init(presenter: AddNotePresentable) {
        self.presenter = presenter
    }
}

extension AddNoteInteractor: AddNoteBusinessLogic {
    func fetchNote(for request: AddNoteModels.FetchRequest) {
        let response = AddNoteModels.Response(note: request.country.note)
        presenter.presentNote(for: response)
    }
    
    func saveNote(_ note: String, for countryID: String) -> Country? {
        let result = countriesWorker.updateNote(note, for: countryID)
        guard let _ = result.value, result.isSuccess else {
            presenter.presentNote(error: result.error ?? .databaseFailure(nil))
            return nil
        }
        NotificationCenter.default.post(name: .countryUpdated, object: nil)
        return result.value
    }
}
