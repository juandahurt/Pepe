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
    static let level = LevelModifier()
    
    /// Modifier that adds the current time to the message.
    static let time = TimeModifier()
    
    /// The default modifier.
    static let pepe = PepeModifier()
    
    /// Modifier that adds the file from where the log was called.
    static let file = FileModifier()
    
    /// Modifies a certain massage.
    /// - Parameters:
    ///   - log: Message to be modified.
    func modify(_ log: inout Log) {}
    
    public static func == (lhs: LogModifier, rhs: LogModifier) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Hi modifier
public class PepeModifier: LogModifier {
    override func modify(_ log: inout Log) {
        log.message = "🐸: \(log.message)"
    }
}

// MARK: - Level modifier
public class LevelModifier: LogModifier {
    override func modify(_ log: inout Log) {
        log.message = "[\(log.level.description)] \(log.message)"
    }
}

// MARK: - Time modifier
public class TimeModifier: LogModifier {
    override func modify(_ log: inout Log) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        log.message = formatter.string(from: log.date).appending(" \(log.message)")
    }
}

// MARK: - File modifier
public class FileModifier: LogModifier {
    private var _showExtension = true
    private var _showLine = false
    
    /// Removes the file extension.
    public func withoutExtension() -> Self {
        _showExtension = false
        return self
    }
    
    /// Shows the line from which the log was called.
    public func withLine() -> Self {
        _showLine = true
        return self
    }
    
    override func modify(_ log: inout Log) {
        guard var url = URL(string: log.file) else { return }
        if !_showExtension { url.deletePathExtension() }
        var fileName = url.lastPathComponent
        if _showLine {
            fileName.append(":\(log.line)")
        }
        log.message = "\(fileName) \(log.message)"
    }
}
