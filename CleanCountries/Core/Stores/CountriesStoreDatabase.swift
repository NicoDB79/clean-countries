//
//  CountriesStoreDatabase.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 12/12/2020.
//

import Foundation
import RealmSwift

struct CountriesStoreDatabase: CountriesStore {
    public init() {
        
    }
}

extension CountriesStoreDatabase {
    
    func fetch(completion: @escaping (Result<[Country], DataError>) -> Void) {
        do {
            let realm = try Realm(configuration: .defaultConfiguration)
            let rCountries = Array(realm.objects(RealmCountry.self))
            let countries = rCountries.map { $0.toCountry() }
            completion(.success(countries))

        } catch let error as NSError {
            completion(.failure(.databaseFailure(error)))
        }
    }
    
    func fetchCountry(id: String, completion: @escaping (Result<Country, DataError>) -> Void) {
        do {
            let realm = try Realm(configuration: .defaultConfiguration)
            let predicate = NSPredicate(format: "id = %@", id)
            guard let rCountry = realm.objects(RealmCountry.self).filter(predicate).first else {
                completion(.failure(.nonExistent))
                return
            }
            let country = rCountry.toCountry()
            completion(.success(country))

        } catch let error as NSError {
            completion(.failure(.databaseFailure(error)))
        }
    }
    
    func search(with request: CountriesModels.SearchRequest, completion: @escaping (Result<[Country], DataError>) -> Void) {
        do {
            let realm = try Realm(configuration: .defaultConfiguration)
            let query = request.query.lowercased()
            let predicate = NSPredicate(format: "name contains[c] %@", query)
            let rCountries = Array(realm.objects(RealmCountry.self).filter(predicate))
            let countries = rCountries.map { $0.toCountry() }
            completion(.success(countries))

        } catch let error as NSError {
            completion(.failure(.databaseFailure(error)))
        }
    }
    
    func updateCountries(_ countries: [Country]) -> Result<[Country], DataError> {
        do {
            let realm = try Realm(configuration: .defaultConfiguration)
            try realm.write {
                
                // First remove countries no more available from API
                let newIds: Array<String> = countries.map({$0.id})
                let storedIds: Array<String> = realm.objects(RealmCountry.self).map({$0.id})
                let countriesToRemove = Array(Set(storedIds).subtracting(newIds))

                if countriesToRemove.count > 0 {
                    realm.delete(realm.objects(RealmCountry.self).filter(NSPredicate(format: "id IN %@", countriesToRemove)))
                }
                
                // Then insert/update the new countries
                for country in countries {
                    let updateDictionary = buildUpdateDictionary(for: country)
                    realm.create(RealmCountry.self, value: updateDictionary, update: .modified)
                }
            }
            let storedCountries = Array(realm.objects(RealmCountry.self).map { $0.toCountry() })
            return .success(storedCountries)
            
        } catch let error as NSError {
            return .failure(.databaseFailure(error))
        }
    }
    
    func updateNote(_ text: String, for countryID: String) -> Result<Country, DataError> {
        do {
            let realm = try Realm(configuration: .defaultConfiguration)
            if let object = realm.object(ofType: RealmCountry.self, forPrimaryKey: countryID) {
                try realm.write {
                    object.note = text
                }
                return .success(object.toCountry())
            } else {
                return .failure(.nonExistent)
            }
            
        } catch let error as NSError {
            return .failure(.databaseFailure(error))
        }
    }
    
    func updateNote(for country: Country) -> Result<Country, DataError> {
        do {
            let realm = try Realm(configuration: .defaultConfiguration)
            try realm.write {
                let updateDictionary = buildNoteUpdateDictionary(for: country)
                realm.create(RealmCountry.self, value: updateDictionary, update: .modified)
            }
            if let object = realm.object(ofType: RealmCountry.self, forPrimaryKey: country.id) {
                return .success(object.toCountry())
            } else {
                return .failure(.nonExistent)
            }
            
        } catch let error as NSError {
            return .failure(.databaseFailure(error))
        }
    }
    
    private func buildUpdateDictionary(for country: Country) -> [String: Any] {
        return ["id": country.id,
                "enabled": country.enabled,
                "code3l": country.code3l,
                "code2l": country.code2l,
                "name": country.name,
                "officialName": country.officialName,
                "flag": country.flag,
                "latitude": country.latitude,
                "longitude": country.longitude,
                "zoom": country.zoom,
                "distance": country.distance] as [String : Any]
    }
    
    private func buildNoteUpdateDictionary(for country: Country) -> [String: Any] {
        return ["id": country.id,
                "note": country.note] as [String : Any]
    }
}
