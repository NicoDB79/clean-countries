//
//  CountriesWorker.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 12/12/2020.
//

struct CountriesWorker {

    private let store: CountriesStore
    
    init(store: CountriesStore) {
        self.store = store
    }
}

extension CountriesWorker {
    
    func fetch(completion: @escaping (Result<[Country], DataError>) -> Void) {
        store.fetch(completion: completion)
    }
    
    func fetch(id: String, completion: @escaping (Result<Country, DataError>) -> Void) {
        store.fetchCountry(id: id, completion: completion)
    }
    
    func search(with request: CountriesModels.SearchRequest, completion: @escaping (Result<[Country], DataError>) -> Void) {
        store.search(with: request, completion: completion)
    }
    
    func updateCountries(_ countries: [Country]) -> Result<[Country], DataError> {
        return store.updateCountries(countries)
    }
    
    func updateNote(_ text: String, for countryID: String) -> Result<Country, DataError> {
        return store.updateNote(text, for: countryID)
    }
    
    func updateNote(for country: Country) -> Result<Country, DataError> {
        return store.updateNote(for: country)
    }
}
