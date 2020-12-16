//
//  CountryDetailPresenter.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 13/12/2020.
//

import UIKit

struct CountryDetailPresenter: CountryDetailPresentable {

    private weak var viewController: CountryDetailDisplayable?
    
    init(viewController: CountryDetailDisplayable?) {
        self.viewController = viewController
    }
}

extension CountryDetailPresenter {
    func presentFetchedCountry(for response: CountryDetailModels.Response) {
        let viewModel = CountryDetailModels.CountryViewModel(
            displayedCountry: make(country: response.country)
        )
        viewController?.displayCountry(with: viewModel)
    }
    
    func presentFetchedCountry(error: DataError) {
        // Handle and parse error
        let viewModel = AppModels.Error(
            title: "Country Error", // TODO: Localize
            message: "There was an error retrieving the country: \(error)" // TODO: Localize
        )
        viewController?.display(error: viewModel, completion: nil)
    }
}

// MARK: - Helpers

private extension CountryDetailPresenter {

    func make(country: Country) -> CountryDetailModels.DisplayedCountry {
        let note = country.note.isEmpty ? "country_note_label_text".localized : country.note
        let noteButtonImage = country.note.isEmpty ? UIImage(named: "noteEmpty")! : UIImage(named: "noteFilled")!
        return CountryDetailModels.DisplayedCountry(name: country.name,
                                                    officialName: country.officialName,
                                                    imageUrl: country.flag,
                                                    code2l: country.code2l,
                                                    code3l: country.code3l,
                                                    latitude: country.latitude,
                                                    longitude: country.longitude,
                                                    zoom: Int(country.zoom) ?? 1,
                                                    note: note,
                                                    noteButtonImage: noteButtonImage)
    }
}
