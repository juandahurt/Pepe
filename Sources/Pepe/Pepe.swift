import Foundation

/// Hi! I'm Pepe, the logger :)
public struct Pepe {
    /// A polite function that gives you a logger instance.
    /// - Returns: A logger instance.
    public static func loggerPlease() -> PepeLogger {
        PepeLogger()
    }
}
