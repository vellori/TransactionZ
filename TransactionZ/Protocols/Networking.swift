//
//  Networking.swift
//  TransactionZ
//
//  Created by André Vellori on 07/02/2019.
//  Copyright © 2019 André Vellori. All rights reserved.
//

import Foundation

protocol Networking {
    @discardableResult func perform(request: URLRequest, callback: @escaping (_ response: NetworkingResponse) -> ()) -> Cancellable
}
