//
//  Logger.swift
//  
//
//  Created by Juan Hurtado on 10/09/23.
//

import Foundation
import os

/// A class that allows you to write modifiable messages through different writers.
public struct PepeLogger {
    /// A set of modifiers to be apllied to every log message.
    /// Notice that, is you set an empty array, the logged string will be the one that you provide.
    var modifiers: [LogModifier]
    
    /// Indicates how the message will be logged or "written". By default, the messages will be logged
    /// on the console.
    var writer: Writer
    
    init() {
        modifiers = [.pepe]
        writer = .console
    }
    
    /// Logs a message using the previously specified writer.
    /// - Parameters:
    ///   - message: Message to be logged.
    ///   - level: Inidicates how important this message is.
    public func log(_ message: String, level: LogLevel = .info) {
        var message = message
        modifiers.reversed().forEach {
            message = $0.modify(message, level: level)
        }
        writer.write(message: message)
    }
}

/// Indicates how important a message is.
public enum LogLevel {
    case info, debug, warning, error
    
    var description: String {
        switch self {
        case .info:
            return "INFO"
        case .debug:
            return "DEBUG"
        case .warning:
            return "WARNING"
        case .error:
            return "ERROR"
        }
    }
}
