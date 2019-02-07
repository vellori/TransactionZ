//
//  TransactionZTests.swift
//  TransactionZTests
//
//  Created by André Vellori on 07/02/2019.
//  Copyright © 2019 André Vellori. All rights reserved.
//

import XCTest
@testable import TransactionZ

class TransactionZTests: XCTestCase {
    
    func testProvidedSuccessScenarios() {
        guard let paths = Bundle(for: TransactionZTests.self).urls(forResourcesWithExtension: "transactionlist", subdirectory: nil) else {
            XCTFail("No test cases found")
            return
        }
        DispatchQueue.concurrentPerform(iterations: paths.count) { (n) in
            let result = try! TransactionListModel.decoder().decode(TransactionListModel.self, from: Data(contentsOf: paths[n]))
            XCTAssertNotNil(result)
            XCTAssertNotNil(result[0])
            XCTAssertNil(result[Int.max])
        }
    }
    
    func testProvidedFailingScenarios() {
        guard let paths = Bundle(for: TransactionZTests.self).urls(forResourcesWithExtension: "failingtransactionlist", subdirectory: nil) else {
            XCTFail("No test cases found")
            return
        }
        DispatchQueue.concurrentPerform(iterations: paths.count) { (n) in
            XCTAssertNil(try? TransactionListModel.decoder().decode(TransactionListModel.self, from: Data(contentsOf: paths[n])))
        }
    }

}
