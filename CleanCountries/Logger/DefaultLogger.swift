//
//  DefaultLogger.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 14/12/2020.
//

import Foundation

public class DefaultLogger: AppLoggerTree {
    
    public var minLevel: AppLogLevel

    public init(_ minLevel: AppLogLevel = .v) {
        self.minLevel = minLevel
    }

    func isLoggingEnabled(logLevel: AppLogLevel) -> Bool {
        return minLevel.rawValue <= logLevel.rawValue
    }

    func log(level: AppLogLevel, _ object: Any, filename: String, line: Int, column: Int, funcName: String) {
        let message = prettyLogMessage(level: level, object, filename: filename, line: line, column: column, funcName: funcName)
        switch level {
        case .v:
            NSLog(message)

        case .d:
            NSLog(message)

        case .i:
            NSLog(message)

        case .w:
            NSLog(message)

        case .e:
            NSLog(message)

        case .s:
            NSLog(message)
        }
    }
    
}
