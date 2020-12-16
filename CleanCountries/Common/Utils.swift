//
//  Utils.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 13/12/2020.
//

import Foundation
import CoreLocation

struct LocationUtils {
    
    static let hqLatitude = 45.554241
    static let hqLongitude = 12.3013643
    static let invalidValue = 9999999999999999.0
    
    static func distanceFromHQ(latitude: String?, longitude: String?) -> Double {
        guard let lat = latitude, let latValue = Double(lat),
              let lon = longitude, let lonValue = Double(lon) else { return invalidValue }
        let coordinate1 = CLLocation(latitude: latValue, longitude: lonValue)
        let coordinate2 = CLLocation(latitude: hqLatitude, longitude: hqLongitude)
        return coordinate2.distance(from: coordinate1)/1000
    }
}
