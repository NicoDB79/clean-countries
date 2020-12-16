//
//  ApiServiceInterface.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 12/12/2020.
//

import Foundation
import CryptoKit

/**
* Class which managed AIR2 SAN API calls
*/
public class ApiService: ApiServiceInterface {
    
    let apiUrl = "https://us-central1-job-interview-cfe5a.cloudfunctions.net/countries"
    let username = "developer"
    let password = "metide"
    
    var token: String?
    
    private func getAuthToken() -> String {
        guard let authToken = token else {
            let loginString = "\(username):\(password)"
            let loginData = loginString.data(using: String.Encoding.utf8)!
            token = "Basic \(loginData.base64EncodedString())"
            return token!
        }
        return authToken
    }
    
    func getCountries(completion: ((Result<[CountryInfo], HttpError>) -> ())?) {
        let request = HttpUtils.Request(method: .GET,
                                        contentType: .JSON,
                                        host: apiUrl,
                                        content: nil,
                                        headers: ["Authorization": getAuthToken()])
        makeRequest(request: request, completion: { dataResponse in
            switch dataResponse {
            case let .success(data):
                guard let countries: [CountryInfo] = try? JSONDecoder().decode([CountryInfo].self, from: data as! Data) else {
                    AppLog.e("Make request: Error deserializing response")
                    let errorResponse = HttpError(code: -1, message: "error deserializing response for getCountries")
                    completion?(.failure(errorResponse))
                    return
                }
                completion?(.success(countries))

            case let .failure(error):
                AppLog.e("error")
                completion?(.failure(HttpError(code: -2, message: "Error requesting getCountries(): \(error.localizedDescription)")))
            }
        })
    }
}


// MARK: Utility methods
extension ApiService {
    
    //MARK: utility methods
    
    /// Make a request
    ///
    /// - Parameters:
    ///     - request: The request struct
    ///     - completion: The completion block with Result type
    internal func makeRequest(request: HttpUtils.Request, completion: ((Result<AnyObject, HttpError>) -> ())?) {

        guard let url = URL(string: request.host) else {
            AppLog.e("Make request: invalid url")
            let errorResponse = HttpError(code: -99, message: "invalid url")
            completion?(.failure(errorResponse))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.stringMethod
        
        // Content-Type
        urlRequest.setValue(request.contentType.stringContentType , forHTTPHeaderField: "Content-Type")
        
        if let headers = request.headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        if let content = request.content {
            switch request.contentType {
            case .URLENCODED:
                let queryString = HttpUtils.queryString(content as! [String : Any])
                urlRequest.url = URL(string: request.host + "?" + queryString)

            case .JSON:
                if content is Data {
                    urlRequest.httpBody = content as? Data
                } else {
                    urlRequest.httpBody = HttpUtils.jsonToNSData(json: content as AnyObject)
                }

            case .OCTET_STREAM:
                urlRequest.httpBody = Data(content as! [UInt8])

            case .MULTIPART:
                // TODO
                break
            }
        }

        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: urlRequest) { (data: Data?, response:URLResponse?, error:Error?) in
            if error == nil, let dataResponse = data {
                let responseCode = (response as! HTTPURLResponse).statusCode
                AppLog.d("Make request: HTTP Code: \(responseCode) -> \(String(describing: response?.url?.absoluteString))")

                guard (200..<300).contains(responseCode) else {
                    AppLog.e("Make request: HTTP error: \(responseCode)")
                    completion?(.failure(HttpError(code: responseCode, message: "Error making a request")))
                    return
                }

                completion?(.success(dataResponse as AnyObject))

            } else {
                AppLog.e("Make request: error making a request: \(error?.localizedDescription ?? "")")
                let errorResponse = HttpError(code: -100, message: "error making a request: \(error?.localizedDescription ?? "")")
                completion?(.failure(errorResponse))
            }
        }
        task.resume()
    }
}
