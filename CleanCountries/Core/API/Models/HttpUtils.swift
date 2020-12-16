//
//  HttpUtils.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 12/12/2020.
//

import Foundation

/**
* Class which contains http utility enum and methods
*/

public class HttpUtils {
    
    public static let FORM_URLENCODED = "application/x-www-form-urlencoded"
    public static let CONTENT_TYPE = "Content-Type"
    public static let GRANT_TYPE = "grant_type"
    public static let CLIENT_ID = "client_id"
    public static let CLIENT_SECRET = "client_secret"
    public static let APPLICATION_JSON = "application/json"
    public static let AUTHORIZATION = "Authorization"
    public static let ACCEPT_LANG = "Accept-language"
    
    public enum HTTPMethod: String {
        case POST
        case PUT
        case GET
        case DELETE
        case PATCH
        
        public var stringMethod: String {
            switch self {
            case .POST:
                return "POST"
            case .PUT:
                return "PUT"
            case .GET:
                return "GET"
            case .DELETE:
                return "DELETE"
            case .PATCH:
                return "PATCH"
            }
        }
    }

    public enum ContentType: String {
        case URLENCODED
        case JSON
        case MULTIPART
        case OCTET_STREAM
        
        public var stringContentType: String {
            switch self {
            case .URLENCODED:
                return "application/x-www-form-urlencoded"
            case .JSON:
                return "application/json"
            case .MULTIPART:
                return "multipart/form-data"
            case .OCTET_STREAM:
                return "application/octet-stream"
            }
        }
    }

    public enum AuthType: String {
        case USER
        case CLIENT
        case NO_AUTH
    }
    
    public enum HTTPschemeType : String {
        case https = "https"
        case http = "http"
        
        func schemeString() -> String {
            switch self {
            case .https:
                return "https://"
            case .http:
                return "http://"
            }
        }
    }
    
    public struct Request {
        public var method: HTTPMethod = .GET
        public var contentType: ContentType = .JSON
        public var host: String =  ""
        public var content: Any?
        public var headers: [String: String]?
        
        public init(method: HTTPMethod = .GET,
             contentType: ContentType = .JSON,
             host: String =  "",
             content: Any?,
             headers: [String: String]?) {
            
            self.method = method
            self.contentType = contentType
            self.host = host
            self.content = content
            self.headers = headers
        }
    }
    
    internal static func escape(_ string: String) -> String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        
        var escaped = ""

        if #available(iOS 8.3, *) {
            escaped = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
        } else {
            let batchSize = 50
            var index = string.startIndex
            
            while index != string.endIndex {
                let startIndex = index
                let endIndex = string.index(index, offsetBy: batchSize, limitedBy: string.endIndex) ?? string.endIndex
                let range = startIndex..<endIndex
                
                let substring = string.substring(with: range)
                
                escaped += substring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? substring
                
                index = endIndex
            }
        }
        
        return escaped
    }
    
    public static func queryString(_ parameters: [String: Any]) -> String {
        func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
            var components: [(String, String)] = []
            
            if let dictionary = value as? [String: Any] {
                for (nestedKey, value) in dictionary {
                    components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
                }
            } else if let array = value as? [Any] {
                for value in array {
                    components += queryComponents(fromKey: "\(key)[]", value: value)
                }
            } else if let value = value as? NSNumber {
                components.append((HttpUtils.escape(key), HttpUtils.escape("\(value)")))
            } else if let bool = value as? Bool {
                components.append((HttpUtils.escape(key), HttpUtils.escape((bool ? "1" : "0"))))
            } else {
                components.append((HttpUtils.escape(key), HttpUtils.escape("\(value)")))
            }
            
            return components
        }
        
        
        var components: [(String, String)] = []
        
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
    
    public static func jsonToNSData(json: AnyObject) -> Data?{
        do {
            return try JSONSerialization.data(withJSONObject: json, options: []) as Data?
        } catch let myJSONError {
            AppLog.d(myJSONError.localizedDescription)
        }
        return nil;
    }
    
}

