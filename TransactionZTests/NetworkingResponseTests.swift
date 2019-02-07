//
//  NetworkingResponseTests.swift
//  TransactionZTests
//
//  Created by André Vellori on 07/02/2019.
//  Copyright © 2019 André Vellori. All rights reserved.
//

import XCTest
@testable import TransactionZ

class NetworkingResponseTests: XCTestCase {

    func testResponse() {
        let response: URLResponse? = HTTPURLResponse(url: URL(string: "http://localhost")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let networking = NetworkingResponse.with(urlResponse: response, data: Data(), error: MockError())
        XCTAssertNotNil(networking.code)
        XCTAssertNotNil(networking.data)
        XCTAssertNotNil(networking.error)
        XCTAssertTrue(networking.error is MockError)
        XCTAssertEqual(networking.headers?.keys.count ?? 0, 0)
    }

}
