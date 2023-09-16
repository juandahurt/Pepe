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
        let reasonableTime = 0.5
        var logger = Pepe.loggerPlease()
        logger.modifiers = [.pepe, .level, .time]
        logger.writer = .os(subsystem: "pepe", category: "perf_test")
        let start = Date()
        logger.log("message")
        let end = Date()
        let interval = end.timeIntervalSinceReferenceDate - start.timeIntervalSinceReferenceDate
        XCTAssertTrue(interval < reasonableTime)
    }
}
