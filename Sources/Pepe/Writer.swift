//
//  Writer.swift
//  
//
//  Created by Juan Hurtado on 14/09/23.
//

import Foundation
import os

public class Writer: Equatable {
    var id: String {
        String(describing: Self.self)
    }
    
    /// The messages will be logged in the console using the `print` function.
    public static var console: ConsoleWriter {
        ConsoleWriter()
    }
    
    /// Please, have in mind that the format of these kind of logs will follow the Apple standars plus
    /// the modifiers that you have provided.
    /// You will see the logged message on the console and on the os logging system.
    /// - Parameters:
    ///   - subsystem: Subsystem identifier.
    ///   - category: Category within the subsystem.
    /// - Returns: A writer to the os logging system.
    public static func os(subsystem: String, category: String) -> OSWriter {
        OSWriter(subsystem: subsystem, category: category)
    }
    
    /// Writes a message.
    /// - Parameter message: Message to be written.
    func write(message: String, level: LogLevel) {
        assert(false, "unreachable")
    }
    
    public static func == (lhs: Writer, rhs: Writer) -> Bool {
        lhs.id == rhs.id
    }
}

public class ConsoleWriter: Writer {
    override func write(message: String, level: LogLevel) {
        print(message)
    }
}

public class OSWriter: Writer {
    private let logger: Logger
    
    init(subsystem: String, category: String) {
        logger = .init(subsystem: subsystem, category: category)
    }
    
    override func write(message: String, level: LogLevel) {
        switch level {
        case .info:
            logger.info("\(message)")
        case .debug:
            logger.debug("\(message)")
        case .warning:
            logger.warning("\(message)")
        case .error:
            logger.error("\(message)")
        }
    }
}
