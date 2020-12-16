//
//  CountriesModels.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 12/12/2020.
//

import Foundation

enum CountriesModels {
    
    public struct SearchRequest {
        let query: String
        
        public init(query: String) {
            self.query = query
        }
    }
}
