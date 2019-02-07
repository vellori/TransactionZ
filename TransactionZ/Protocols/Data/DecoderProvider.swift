//
//  DecoderProvider.swift
//  TransactionZ
//
//  Created by André Vellori on 07/02/2019.
//  Copyright © 2019 André Vellori. All rights reserved.
//

import Foundation

protocol DecoderProvider {
    static func decoder() -> JSONDecoder
}
