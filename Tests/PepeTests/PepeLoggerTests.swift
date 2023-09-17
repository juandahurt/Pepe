//
//  PepeLoggerTests.swift
//  
//
//  Created by Juan Hurtado on 15/09/23.
//

import XCTest
@testable import Pepe

final class PepeLoggerTests: XCTestCase {
    func testState_whenInit_shouldBeDefaultOne() {
        let logger = Pepe.loggerPlease()
        XCTAssertEqual(logger.modifiers, [.pepe])
        XCTAssertEqual(logger.writer, .console)
        XCTAssertEqual(logger.executionType, .sync)
    }
    
    func testLogging_withHeavyConfig_shouldExecuteWithReasonableTime() {
        let reasonableTime = 0.1
        var logger = Pepe.loggerPlease()
        logger.modifiers = [
            .pepe,
            .file.withLine(),
            .level,
            .time
        ]
        logger.writer = .os(subsystem: "pepe", category: "perf_test")
        let start = Date()
        logger.log("message")
        let end = Date()
        let interval = end.timeIntervalSinceReferenceDate - start.timeIntervalSinceReferenceDate
        XCTAssertTrue(interval < reasonableTime)
    }
    
    func testLogging_withObserver_logCountShouldBeEqualToExpected() {
        var logger = Pepe.loggerPlease()
        let mockObserver = MockObserver()
        logger.observer = mockObserver
        logger.log("Hello")
        logger.log("World!")
        XCTAssertEqual(mockObserver.logCount, 2)
    }
}


// MARK: Helpers
internal class MockObserver: LoggerObserver {
    var logCount = 0
    
    func willLog(log: Log) {
        logCount += 1
    }
}
