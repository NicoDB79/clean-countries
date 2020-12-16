//
//  CountriesStoreAPI.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 12/12/2020.
//

import Foundation

struct CountriesStoreAPI: CountriesStore {
    static var countries: [Country] = [
        Country(id: "79",
                enabled: true,
                code3l: "ITA",
                code2l: "IT",
                name: "Italy",
                officialName: "Republic of Italy",
                flag: "",
                latitude: "41.77810840",
                longitude: "12.67725128",
                zoom: "5"),
        
        Country(id: "153",
                enabled: true,
                code3l: "ESP",
                code2l: "ES",
                name: "Spain",
                officialName: "Kingdom of Spain",
                flag: "",
                latitude: "39.87299401",
                longitude: "-3.67089492",
                zoom: "6")
    ]
}

extension CountriesStoreAPI {
    
    func fetch(completion: @escaping (Result<[Country], DataError>) -> Void) {
        completion(.success(Self.countries))
    }
    
    func fetchCountry(id: String, completion: @escaping (Result<Country, DataError>) -> Void) {
        guard let country = Self.countries.first(where: { $0.id == id }) else {
            return completion(.failure(.nonExistent))
        }
        
        completion(.success(country))
    }
    
    func search(with request: CountriesModels.SearchRequest, completion: @escaping (Result<[Country], DataError>) -> Void) {
        let query = request.query.lowercased()
        let countries = Self.countries.filter {
            $0.name.lowercased().contains(query) || $0.name.lowercased().contains(query)
        }
        
        completion(.success(countries))
    }
    
    func updateCountries(_ countries: [Country]) -> Result<[Country], DataError> {
        return .success([])
    }
    
    func updateNote(_ text: String, for countryID: String) -> Result<Country, DataError> {
        return .success(Country())
    }
    
    func updateNote(for country: Country) -> Result<Country, DataError> {
        return .success(Country())
    }
}
