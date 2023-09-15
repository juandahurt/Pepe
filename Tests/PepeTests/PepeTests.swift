import XCTest
@testable import Pepe

final class PepeTests: XCTestCase {
    func test() {
        var logger = Pepe.loggerPlease()
        logger.modifiers = [.level, .time]
        logger.log("Hello world!")
    }
}
