//
//  CountryInfo.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 12/12/2020.
//

import Foundation

class CountryInfo: HttpCodableResponse {
    
    public private (set) var id: String?
    public private (set) var enabled: Bool?
    public private (set) var code3l: String?
    public private (set) var code2l: String?
    public private (set) var name: String?
    public private (set) var officialName: String?
    public private (set) var flag: String?
    public private (set) var latitude: String?
    public private (set) var longitude: String?
    public private (set) var zoom: String?

    private enum CodingKeys : String, CodingKey {
        case id = "id"
        case enabled = "enabled"
        case code3l = "code3l"
        case code2l = "code2l"
        case name = "name"
        case officialName = "name_official"
        case flag = "flag"
        case latitude = "latitude"
        case longitude = "longitude"
        case zoom = "zoom"
    }
    
    init(id: String?,
         enabled: Bool?,
         code3l: String?,
         code2l: String?,
         name: String?,
         officialName: String?,
         flag: String?,
         latitude: String?,
         longitude: String?,
         zoom: String?) {
        
        self.id = id
        self.enabled = enabled
        self.code3l = code3l
        self.code2l = code2l
        self.name = name
        self.officialName = officialName
        self.flag = flag
        self.latitude = latitude
        self.longitude = longitude
        self.zoom = zoom
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(String.self, forKey: .id)
        if let enabledString: String = try? container.decode(String.self, forKey: .enabled) {
            self.enabled = enabledString.boolValue
        }
        
        self.code3l = try? container.decode(String.self, forKey: .code3l)
        self.code2l = try? container.decode(String.self, forKey: .code2l)
        self.name = try? container.decode(String.self, forKey: .name)
        self.officialName = try? container.decode(String.self, forKey: .officialName)
        self.flag = try? container.decode(String.self, forKey: .flag)
        self.latitude = try? container.decode(String.self, forKey: .latitude)
        self.longitude = try? container.decode(String.self, forKey: .longitude)
        self.zoom = try? container.decode(String.self, forKey: .zoom)
        try super.init(from: decoder)
    }
}
