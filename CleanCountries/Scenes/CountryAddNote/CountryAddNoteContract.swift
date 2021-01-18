//
//  CountryAddNoteContract.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 18/01/2021.
//  
//

import Foundation

// MARK: View Protocol
protocol CountryAddNoteViewProtocol: class, AppDisplayable {
    func displayNote(with viewModel: CountryAddNoteModels.NoteViewModel)
}

// MARK: Interactor Protocol
protocol CountryAddNoteInteractorProtocol {
    func fetchNote(for request: CountryAddNoteModels.FetchRequest)
    func saveNote(_ note: String, for countryID: String) -> Country?
}

// MARK: Presenter Protocol
protocol CountryAddNotePresenterProtocol {
    func presentNote(for response: CountryAddNoteModels.Response)
    func presentNote(error: DataError)
}

// MARK: Router Protocol
protocol CountryAddNoteRouterProtocol {
    func close()
}
