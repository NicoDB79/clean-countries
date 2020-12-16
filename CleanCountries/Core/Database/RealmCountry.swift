//
//  RealmCountry.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 12/12/2020.
//

import Foundation
import RealmSwift

@objcMembers class RealmCountry: Object {
    dynamic var id: String = ""
    dynamic var enabled: Bool = true
    dynamic var code3l: String = ""
    dynamic var code2l: String = ""
    dynamic var name: String = ""
    dynamic var officialName: String = ""
    dynamic var flag: String = ""
    dynamic var latitude: String = ""
    dynamic var longitude: String = ""
    dynamic var zoom: String = ""
    dynamic var distance: Double = 0.0
    dynamic var note: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension RealmCountry {
    func toCountry() -> Country {
        return Country(id: id,
                       enabled: enabled,
                       code3l: code3l,
                       code2l: code2l,
                       name: name,
                       officialName: officialName,
                       flag: flag,
                       latitude: latitude,
                       longitude: longitude,
                       zoom: zoom,
                       distance: distance,
                       note: note)
    }
    
    func fromCountry(_ country: Country) {
        id = country.id
        enabled = country.enabled
        code3l = country.code3l
        code2l = country.code2l
        name = country.name
        officialName = country.officialName
        flag = country.flag
        latitude = country.latitude
        longitude = country.longitude
        zoom = country.zoom
        distance = country.distance
        note = country.note
    }
}
