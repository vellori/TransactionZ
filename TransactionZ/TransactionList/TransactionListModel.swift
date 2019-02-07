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
}



/*
 {
 "id": "13acb877dc4d8030c5dac1223bde33d3496a2ae3c000db4c793bda9c3228baca1a28",
 "date": "2018-03-01",
 "description": "Just eat",
 "category_id": 6,
 "currency": "GBP",
 "amount": {
 "value": 13,
 "currency_iso": "GBP"
 },
 "product": {
 "id": 4279,
 "title": "Lloyds Bank",
 "icon": "https://storage.googleapis.com/budcraftstorage/uploads/products/lloyds-bank/Llyods_Favicon-1_161201_091641.jpg"
 }
 },
 */
