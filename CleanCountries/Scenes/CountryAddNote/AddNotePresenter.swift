//
//  AddNotePresenter.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 13/12/2020.
//

struct AddNotePresenter: AddNotePresentable {

    private weak var viewController: AddNoteDisplayable?
    
    init(viewController: AddNoteDisplayable?) {
        self.viewController = viewController
    }
}

extension AddNotePresenter {
    
    func presentNote(for response: AddNoteModels.Response) {
        let viewModel = AddNoteModels.NoteViewModel(
            displayedNote: AddNoteModels.DisplayedNote(note: response.note)
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
