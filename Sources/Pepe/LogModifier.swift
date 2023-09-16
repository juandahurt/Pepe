//
//  LogModifier.swift
//  
//
//  Created by Juan Hurtado on 11/09/23.
//

import Foundation

/// A log modifier modifies a message before logging it.
///
/// You can have your own custom modifier by implmenting this class.
public class LogModifier: Equatable {
    /// Modifier identifier.
    var id: String {
        String(describing: Self.self)
    }
    
    /// Modifier that adds the log level to the message.
    static var level: LevelModifier {
        LevelModifier()
    }
    
    /// Modifier that adds the current time to the message.
    static var time: TimeModifier {
        TimeModifier()
    }
    
    /// The default modifier.
    static var pepe: PepeModifier {
        PepeModifier()
    }
    
    /// Modifies a certain massage.
    /// - Parameters:
    ///   - message: Message to be modified.
    ///   - level: Log level.
    func modify(_ message: String, level: LogLevel) -> String {
        message
    }
    
    public static func == (lhs: LogModifier, rhs: LogModifier) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Hi modifier
public class PepeModifier: LogModifier {
    override func modify(_ message: String, level: LogLevel) -> String {
        "🐸: \(message)"
    }
}

// MARK: - Level modifier
public class LevelModifier: LogModifier {
    override func modify(_ message: String, level: LogLevel) -> String {
        "[\(level.description)] \(message)"
    }
}

// MARK: - Time modifier
public class TimeModifier: LogModifier {
    override func modify(_ message: String, level: LogLevel) -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        return formatter.string(from: now).appending(" \(message)")
    }
}
