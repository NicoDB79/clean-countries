//
//  ApiServiceInterface.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 12/12/2020.
//

import Foundation
import CryptoKit

protocol ApiServiceInterface {
    /**
     Returns the array of countries
     - Parameters:
        - completion: completion block with Result Type (if success returns an array of DealerInfo; if failure, returns the HttpError object)
     */
    func getCountries(completion: ((Result<[CountryInfo], HttpError>) -> ())?)
}


extension Digest {
    var bytes: [UInt8] { Array(makeIterator()) }
    var data: Data { Data(bytes) }

    var hexStr: String {
        bytes.map { String(format: "%02X", $0) }.joined()
    }
}
