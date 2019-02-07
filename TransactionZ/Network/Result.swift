//
//  Result.swift
//  TransactionZ
//
//  Created by André Vellori on 07/02/2019.
//  Copyright © 2019 André Vellori. All rights reserved.
//

import Foundation

enum Result<Value: Decodable & DecoderProvider> {
    case success(value: Value)
    case error(error: Cause)
    
    static func with(response: NetworkingResponse) -> Result<Value> {
        guard let data = response.data,
            // a bit of logging for troubleshooting here, if needed
            let object = try? Value.decoder().decode(Value.self, from: data) else {
                return Result<Value>.error(error: Cause.with(response: response))
        }
        return Result<Value>.success(value: object)
    }
}

enum Cause {
    case generalFailure
    
    static func with(response: NetworkingResponse) -> Cause {
        return .generalFailure
    }
}
