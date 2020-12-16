//
//  CountriesStoreAPI.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 12/12/2020.
//

import Foundation

class CountriesStoreAPI: CountriesStore {

    let apiService = ApiService()
    var countries = [Country]()
    private var networkMonitor = Reach()
    
    func fetch(completion: @escaping (Result<[Country], DataError>) -> Void) {
        switch networkMonitor.connectionStatus() {
        case .offline, .unknown:
            completion(.failure(DataError.noInternet))
        default: break
        }
        
        apiService.getCountries { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(countriesInfo):
                self.countries = Country.fromCountryInfoList(countriesInfo)
                completion(.success(self.countries))
            case let .failure(error):
                AppLog.e("error: \(error.localizedDescription)")
                completion(.failure(DataError.parseFailure(error)))
            }
        }
    }
    
    func fetchCountry(id: String, completion: @escaping (Result<Country, DataError>) -> Void) {
        guard let country = countries.first(where: { $0.id == id }) else {
            return completion(.failure(.nonExistent))
        }

        completion(.success(country))
    }
    
    func search(with request: CountriesModels.SearchRequest, completion: @escaping (Result<[Country], DataError>) -> Void) {
        let query = request.query.lowercased()
        let filteredCountries = countries.filter {
            $0.name.lowercased().contains(query) || $0.name.lowercased().contains(query)
        }

        completion(.success(filteredCountries))
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
