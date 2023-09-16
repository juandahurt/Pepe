//
//  PepeLoggerTests.swift
//  
//
//  Created by Juan Hurtado on 15/09/23.
//

import XCTest
@testable import Pepe

final class PepeLoggerTests: XCTestCase {
    func test_initialState_shouldBeDefaultOne() {
        let logger = Pepe.loggerPlease()
        XCTAssertEqual(logger.modifiers, [.pepe])
        XCTAssertEqual(logger.writer, .console)
    }
}
