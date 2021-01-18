//
//  CountryAddNotePresenter.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 18/01/2021.
//  
//

import Foundation

class CountryAddNotePresenter {

    // MARK: Properties
    weak var viewController: CountryAddNoteViewProtocol?
}

extension CountryAddNotePresenter: CountryAddNotePresenterProtocol {
    
    func presentNote(for response: CountryAddNoteModels.Response) {
        let viewModel = CountryAddNoteModels.NoteViewModel(
            displayedNote: CountryAddNoteModels.DisplayedNote(note: response.note)
        )
        viewController?.displayNote(with: viewModel)
    }
    
    func presentNote(error: DataError) {
        // Handle and parse error
        let viewModel = AppModels.Error(
            title: "Note Error", // TODO: Localize
            message: "There was an error retrieving the note: \(error)" // TODO: Localize
        )
        viewController?.display(error: viewModel, completion: nil)
    }
}
