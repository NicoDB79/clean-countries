//
//  AppLog.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 14/12/2020.
//

import Foundation

/// Enum which maps an appropiate symbol which added as prefix for each log message
///
/// - error: Log type error
/// - info: Log type info
/// - debug: Log type debug
/// - verbose: Log type verbose
/// - warning: Log type warning
/// - severe: Log type severe
public enum AppLogLevel: Int {
    case v = 0
    case d = 1
    case i = 2
    case w = 3
    case e = 4
    case s = 5
    
    public func description() -> String {
        switch self {
        case .v:
            return "[🔬]" // verbose
            
        case .d:
            return "[💬]" // debug
            
        case .i:
            return "[ℹ️]" // info
            
        case .w:
            return "[⚠️]" // warning
            
        case .e:
            return "[‼️]" // error
            
        case .s:
            return "[🔥]" // severe
        }
    }
}

public class AppLog: NSObject {
    
    private static var loggerTreeList = [AppLoggerTree]()
    
    static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }

    static func plant(tree: AppLoggerTree) {
        loggerTreeList.append(tree)
    }
    
    public static func e( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        for logger in loggerTreeList {
            logger.e(object, filename: filename, line: line, column: column, funcName: funcName)
        }
    }

    public static func i( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        for logger in loggerTreeList {
            logger.i(object, filename: filename, line: line, column: column, funcName: funcName)
        }
    }

    public static func d( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        for logger in loggerTreeList {
            logger.d(object, filename: filename, line: line, column: column, funcName: funcName)
        }
    }
    
    @objc public static func v( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        for logger in loggerTreeList {
            logger.v(object, filename: filename, line: line, column: column, funcName: funcName)
        }
    }

    public static func w( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        for logger in loggerTreeList {
            logger.w(object, filename: filename, line: line, column: column, funcName: funcName)
        }
    }
    
    public static func s( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        for logger in loggerTreeList {
            logger.s(object, filename: filename, line: line, column: column, funcName: funcName)
        }
    }
    
    public static func log(level: AppLogLevel,  _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        for logger in loggerTreeList {
            logger.log(level: level, object, filename: filename, line: line, column: column, funcName: funcName)
        }
    }
    
}

protocol AppLoggerTree {
    func isLoggingEnabled(logLevel: AppLogLevel) -> Bool
    func log(level: AppLogLevel,  _ object: Any, filename: String, line: Int, column: Int, funcName: String)
}

extension AppLoggerTree {
    
    /// Returns true if the log is enabled for the level passed in input
    public func isLoggingEnabled(logLevel: AppLogLevel) -> Bool {
        return true
    }
    
    /// Logs error messages with the level provided in input. Default implementation uses NSLog()
    ///
    /// - Parameters:
    ///   - logEvent: log level
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    public func log(level: AppLogLevel,  _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        NSLog(prettyLogMessage(level: level, object, filename: filename, line: line, column: column, funcName: funcName))
    }
    
    /// Logs error messages on console with prefix [‼️]
    ///
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    func e( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        prepareLog(level: .e, object, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    
    /// Logs info messages on console with prefix [ℹ️]
    ///
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    func i( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        prepareLog(level: .i, object, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    /// Logs debug messages on console with prefix [💬]
    ///
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    func d( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        prepareLog(level: .d, object, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    
    /// Logs messages verbosely on console with prefix [🔬]
    ///
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    func v( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        prepareLog(level: .v, object, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    
    /// Logs warnings verbosely on console with prefix [⚠️]
    ///
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    func w( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        prepareLog(level: .w, object, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    
    /// Logs severe events on console with prefix [🔥]
    ///
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    func s( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        prepareLog(level: .s, object, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    /// Build a pretty default log message
    ///
    /// - Parameters:
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    /// - Returns: the log message
    public func prettyLogMessage(level: AppLogLevel,  _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) -> String {
        return "\(Date().prettyLog()) \(level.description())[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)"
    }
    
    /// Prepare the log checking log level
    ///
    /// - Parameters:
    ///   - level: log level
    ///   - object: Object or message to be logged
    ///   - filename: File name from where loggin to be done
    ///   - line: Line number in file from where the logging is done
    ///   - column: Column number of the log message
    ///   - funcName: Name of the function from where the logging is done
    internal func prepareLog(level: AppLogLevel,  _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if !isLoggingEnabled(logLevel: level) { return }
        log(level: level, object, filename: filename, line: line, column: column, funcName: funcName)
    }
    
    /// Extract the file name from the file path
    ///
    /// - Parameter filePath: Full file path in bundle
    /// - Returns: File Name with extension
    internal func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}

internal extension Date {
    func prettyLog() -> String {
        return AppLog.dateFormatter.string(from: self as Date)
    }
}
