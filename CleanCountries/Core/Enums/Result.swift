//
//  Result.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 29/10/2020.
//

enum Result<Value, ErrorType: Error> {
    case success(Value)
    case failure(ErrorType)
    
    /// Returns `true` if the result is a success, `false` otherwise.
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    /// Returns `true` if the result is a failure, `false` otherwise.
    var isFailure: Bool {
        return !isSuccess
    }
    
    /// Returns the associated value if the result is a success, `nil` otherwise.
    var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    var error: ErrorType? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

