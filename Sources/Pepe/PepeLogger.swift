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
    public var modifiers: [LogModifier]
    
    /// Indicates how the message will be logged or "written". By default, the messages will be logged
    /// on the console.
    public var writer: Writer
    
    /// How the log operation will be executed.
    public var executionType: ExecutionType
    
    /// It allows you to observe the logger. Note that the `executionType` is attatched not only to the
    /// logging itself but also to this observer.
    public var observer: LoggerObserver?
    
    /// Internal property to allow syncronous execution.
    private let _lock = NSRecursiveLock()
    
    public enum ExecutionType: Equatable {
        case async(DispatchQueue), sync
    }
    
    init() {
        modifiers = [.pepe]
        writer = .console
        executionType = .sync
    }
    
    /// Logs a message using the previously specified writer.
    /// - Parameters:
    ///   - message: Message to be logged.
    ///   - level: Inidicates how important this message is.
    public func log(_ message: String, level: LogLevel = .info, file: String = #file, line: Int = #line) {
        switch executionType {
        case .async(let dispatchQueue):
            dispatchQueue.async {
                _log(message, level: level, file: file, line: line)
            }
        case .sync:
            _lock.lock(); defer { _lock.unlock() }
            _log(message, level: level, file: file, line: line)
        }
    }
    
    private func _log(_ message: String, level: LogLevel, file: String, line: Int) {
        var log = Log(message: message, level: level, file: file, line: line)
        modifiers.reversed().forEach {
            $0.modify(&log)
        }
        observer?.willLog(log: log)
        writer.write(message: log.message)
    }
}


/// This protocol allows you to observe the logger.
public protocol LoggerObserver {
    /// It notifies the observer that a message is about to be logged.
    /// - Parameter log: Object that contains the log itself.
    func willLog(log: Log)
}
