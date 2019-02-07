//
//  TransactionDetailModel.swift
//  TransactionZ
//
//  Created by André Vellori on 07/02/2019.
//  Copyright © 2019 André Vellori. All rights reserved.
//

import Foundation

struct TransactionDetailModel: Decodable, DecoderProvider {
    var date: Date
    var description: String
    var currency: String
    var amount: Amount
    var product: Product
    
    static func decoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return decoder
    }
}

struct Product: Decodable {
    var title: String
    var icon: URL
}

struct Amount: Decodable {
    var value: Decimal
    var currency_iso: String
}
