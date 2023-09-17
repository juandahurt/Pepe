//
//  Log.swift
//  
//
//  Created by Juan Hurtado on 16/09/23.
//

import Foundation

struct Log {
    /// Message to be logged.
    var message: String
    
    /// How importante the log is.
    let level: LogLevel
    
    /// The time when the message is logged.
    let date: Date
    
    /// The file from where the log was called.
    let file: String
    
    /// The line from which the log was called.
    let line: Int
    
    init(message: String, level: LogLevel, file: String, line: Int) {
        self.message = message
        self.level = level
        self.date = Date()
        self.file = file
        self.line = line
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
