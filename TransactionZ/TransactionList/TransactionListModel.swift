//
//  ListModel.swift
//  TransactionZ
//
//  Created by André Vellori on 07/02/2019.
//  Copyright © 2019 André Vellori. All rights reserved.
//

import Foundation

struct TransactionListModel: Decodable, DecoderProvider {
    var data: [TransactionDetailModel]
    
    static func decoder() -> JSONDecoder {
        return TransactionDetailModel.decoder()
    }
    
    static var empty: TransactionListModel {
        return TransactionListModel(data: [])
    }
    
    subscript(index: Int) -> TransactionDetailModel {
        get {
            return data[index]
        }
        set(newValue) {
            fatalError()
        }
    }
}
