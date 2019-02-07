//
//  Networking+URLSession.swift
//  TransactionZ
//
//  Created by André Vellori on 07/02/2019.
//  Copyright © 2019 André Vellori. All rights reserved.
//

import Foundation

struct NetworkingResponse {
    var code: Int?
    var headers: [AnyHashable: Any]?
    var data: Data?
    var error: Error?
    
    static func with(urlResponse: URLResponse?, data: Data?, error: Error?) -> NetworkingResponse {
        let httpResponse = urlResponse as? HTTPURLResponse
        return NetworkingResponse(code: httpResponse?.statusCode, headers: httpResponse?.allHeaderFields, data: data, error: error)
    }
}


extension URLSessionDataTask: Cancellable {}

extension URLSession: Networking {
    @discardableResult func perform(request: URLRequest, callback: @escaping (_ response: NetworkingResponse) -> ()) -> Cancellable {
        let datatask = self.dataTask(with: request) { (data, urlResponse, error) in
            callback(NetworkingResponse.with(urlResponse: urlResponse, data: data, error: error))
        }
        datatask.resume()
        return datatask
    }
}
