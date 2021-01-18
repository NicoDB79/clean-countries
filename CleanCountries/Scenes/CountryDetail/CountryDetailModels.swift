//
//  CountryDetailModels.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 13/12/2020.
//
import UIKit

enum CountryDetailModels {
    
    struct FetchRequest {
        let country: Country
    }
    
    struct Response {
        let country: Country
    }
    
    struct CountryViewModel {
        let displayedCountry: DisplayedCountry
    }
    
    struct DisplayedCountry {
        let name: String
        let officialName: String
        let imageUrl: String?
        let code2l: String
        let code3l: String
        let latitude: String
        let longitude: String
        let zoom: Int
        let note: String
        let noteButtonImage: UIImage
    }
}
