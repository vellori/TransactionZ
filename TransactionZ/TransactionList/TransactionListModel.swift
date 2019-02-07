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
    
    subscript(index: Int) -> TransactionDetailModel? {
        get {
            guard index < data.count else {
                return nil
            }
            return data[index]
        }
        set(newValue) {
            fatalError()
        }
    }
}

extension TransactionListModel: Collection {
    func index(after i: Int) -> Int {
        return i + 1
    }
    
    var startIndex: Int {
        return 0
    }
    
    var endIndex: Int {
        return data.count - 1
    }
    
    
}
