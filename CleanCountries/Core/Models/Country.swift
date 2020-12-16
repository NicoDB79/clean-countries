//
//  Country.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 12/12/2020.
//

import Foundation

struct Country: Equatable {
    var id: String = ""
    var enabled: Bool = true
    var code3l: String = ""
    var code2l: String = ""
    var name: String = ""
    var officialName: String = ""
    var flag: String = ""
    var latitude: String = ""
    var longitude: String = ""
    var zoom: String = ""
    var distance: Double = 0.0
    var note: String = ""
    
    static func ==(lhs: Country, rhs: Country) -> Bool {
      return lhs.id == rhs.id &&
        lhs.enabled == rhs.enabled &&
        lhs.code3l == rhs.code3l &&
        lhs.code2l == rhs.code2l &&
        lhs.name == rhs.name &&
        lhs.officialName == rhs.officialName &&
        lhs.flag == rhs.flag &&
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude &&
        lhs.zoom == rhs.zoom &&
        lhs.distance == rhs.distance &&
        lhs.note == rhs.note
    }
}

extension Country {
    static func fromCountryInfoList(_ list: [CountryInfo]) -> [Country] {
        // filter countries with valid coordinates
        let filteredCountries = list.filter { $0.latitude?.isEmpty == false && $0.longitude?.isEmpty == false }
        return filteredCountries.map { Self.make(country: $0) }
    }
    
    private static func make(country: CountryInfo) -> Country {
        return Country(id: country.id ?? "",
                       enabled: country.enabled ?? false,
                       code3l: country.code3l ?? "",
                       code2l: country.code2l ?? "",
                       name: country.name ?? "",
                       officialName: country.officialName ?? "",
                       flag: country.flag ?? "",
                       latitude: country.latitude ?? "",
                       longitude: country.longitude ?? "",
                       zoom: country.zoom ?? "",
                       distance: LocationUtils.distanceFromHQ(latitude: country.latitude,
                                                              longitude: country.longitude),
                       note: "")
    }
}

extension Array where Element == Country {
    func sortByDistance() -> [Country] {
        return self.sorted(by: { $0.distance < $1.distance })
    }
}
