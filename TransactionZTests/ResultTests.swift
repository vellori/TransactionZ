//
//  ResultTests.swift
//  TransactionZTests
//
//  Created by André Vellori on 07/02/2019.
//  Copyright © 2019 André Vellori. All rights reserved.
//

import Foundation
import XCTest
@testable import TransactionZ

class ResultTests: XCTestCase {
    func testCauseKO() {
        XCTAssertEqual(Cause.with(response: NetworkingResponse(code: 500, headers: nil, data: Data(), error: nil)), .generalFailure)
        XCTAssertEqual(Cause.with(response: NetworkingResponse(code: 200, headers: nil, data: nil, error: MockError())), .generalFailure)
        XCTAssertEqual(Cause.with(response: NetworkingResponse(code: 404, headers: nil, data: nil, error: MockError())), .generalFailure)
    }
}

struct MockError: Error {}
