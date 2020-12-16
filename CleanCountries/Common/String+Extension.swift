//
//  String+Extension.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 12/12/2020.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var boolValue: Bool {
        return (self as NSString).boolValue
    }
}
