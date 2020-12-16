//
//  AddNoteInterfaces.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 13/12/2020.
//

protocol AddNoteDisplayable: class, AppDisplayable { // View Controller
    func displayNote(with viewModel: AddNoteModels.NoteViewModel)
}

protocol AddNoteBusinessLogic { // Interactor
    func fetchNote(for request: AddNoteModels.FetchRequest)
    func saveNote(_ note: String, for countryID: String) -> Country?
}

protocol AddNotePresentable { // Presenter
    func presentNote(for response: AddNoteModels.Response)
    func presentNote(error: DataError)
}

protocol AddNoteRoutable: AppRoutable { // Router
    func close()
}
