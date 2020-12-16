//
//  CountriesStoreInterfaces.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 12/12/2020.
//

protocol CountriesStore {
    func fetch(completion: @escaping (Result<[Country], DataError>) -> Void)
    func fetchCountry(id: String, completion: @escaping (Result<Country, DataError>) -> Void)
    func search(with request: CountriesModels.SearchRequest, completion: @escaping (Result<[Country], DataError>) -> Void)
    func updateCountries(_ countries: [Country]) -> Result<[Country], DataError>
    func updateNote(_ text: String, for countryID: String) -> Result<Country, DataError>
    func updateNote(for country: Country) -> Result<Country, DataError>
}

protocol CountriesWorkerType: CountriesStore {

}
