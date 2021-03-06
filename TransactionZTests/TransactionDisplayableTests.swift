//
//  TransactionDisplayableTests.swift
//  TransactionZTests
//
//  Created by André Vellori on 07/02/2019.
//  Copyright © 2019 André Vellori. All rights reserved.
//

import XCTest
@testable import TransactionZ

class TransactionDisplayableTests: XCTestCase {
    func testSimpleDongTransaction() {
        let transaction = TransactionDetailModel.with(amount: Amount(value: 12.3, currency_iso: "VND"))
        let testUI = TestUI()
        testUI.apply(transaction: transaction, imageLoader: ImageLoader(networking: MockNetworking()))
        XCTAssertEqual(testUI.amountLabel?.text, "₫12.30")
        XCTAssertEqual(testUI.descriptionLabel?.text, "desc")
    }
    
    func testSimpleDollarTransaction() {
        let transaction = TransactionDetailModel.with(amount: Amount(value: 12.3, currency_iso: "USD"))
        let testUI = TestUI()
        testUI.apply(transaction: transaction, imageLoader: ImageLoader(networking: MockNetworking()))
        XCTAssertEqual(testUI.amountLabel?.text, "$12.30")
        XCTAssertEqual(testUI.descriptionLabel?.text, "desc")
    }
}


private struct TestUI: TransactionDisplayable {
    var descriptionLabel: UILabel! = UILabel()
    var amountLabel: UILabel! = UILabel()
    var productImageView: UIImageView! = UIImageView()
}

extension TransactionDetailModel {
    static func with(amount: Amount) -> TransactionDetailModel {
        return TransactionDetailModel(date: Date(), description: "desc", currency: "XXX", amount: amount, product: Product(title: "abc", icon: URL(string: "http://localhost")!))
    }
}
