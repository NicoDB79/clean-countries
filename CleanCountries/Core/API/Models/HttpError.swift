//
//  HttpError.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 12/12/2020.
//

import Foundation

public class HttpError: Error {
    public private (set) var code: Int = 0
    public private (set) var message: String
    
    public init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
}
