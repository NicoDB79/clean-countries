//
//  CountryListModels.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 12/12/2020.
//

enum CountryListModels {
    
    struct SearchRequest {
        let text: String
    }
    
    struct Response {
        let countries: [Country]
    }
    
    struct ListViewModel {
        let displayedCountries: [DisplayedCountry]
    }
    
    struct DisplayedCountry {
        let id: String
        let name: String
        let imageUrl: String?
    }
}
