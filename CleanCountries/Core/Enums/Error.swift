//
//  Error.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 12/12/2020.
//

enum DataError: Error {
    case nonExistent
    case unauthorized
    case noInternet
    case parseFailure(Error?)
    case databaseFailure(Error?)
    case cacheFailure(Error?)
    case networkFailure(Error?)
    case unknownReason(Error?)
}
