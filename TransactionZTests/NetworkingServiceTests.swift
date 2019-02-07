//
//  NetworkingServiceTests.swift
//  TransactionZTests
//
//  Created by André Vellori on 07/02/2019.
//  Copyright © 2019 André Vellori. All rights reserved.
//

import XCTest
@testable import TransactionZ

class NetworkingServiceTests: XCTestCase {
    func testClientSuccess() {
        let mocker = MockNetworking()
        let client = NetworkingService(client: mocker)
        mocker.mocked = "{}".data(using: .utf8)!
        let callSuccess = expectation(description: "Call Success!")
        client.get(url: URL(string: "http://localhost")!) { (result: Result<MockModel>) in
            switch result {
            case .success(_):
                callSuccess.fulfill()
            default:
                XCTFail()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
        mocker.wait = 0.1
        let callFailed = expectation(description: "Should be cancelled")
        let operation = client.get(url: URL(string: "http://lcoalhost")!) { (result: Result<MockModel>) in
            switch result {
            case .success(_):
                XCTFail()
            default:
                callFailed.fulfill()
            }
        }
        operation.cancel()
        waitForExpectations(timeout: 0.2, handler: nil)
        
        
    }
}

struct MockModel: Codable, DecoderProvider {
    var name: String?
    
    static func decoder() -> JSONDecoder {
        return JSONDecoder()
    }
}

class MockNetworking: Networking, Cancellable {
    var mocked: Data = Data()
    var status = 200
    var error: Error? = nil
    
    var wait: TimeInterval = 0
    
    var cancelled = false
    
    func cancel() {
        cancelled = true
    }
    
    func perform(request: URLRequest, callback: @escaping (NetworkingResponse) -> ()) -> Cancellable {
        let response = NetworkingResponse(code: status, headers: nil, data: mocked, error: error)
        let wait = self.wait
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: wait)
            if self.cancelled {
                callback(NetworkingResponse(code: nil, headers: nil, data: nil, error: nil))
            } else {
                callback(response)
            }
        }
        return self
    }
}
