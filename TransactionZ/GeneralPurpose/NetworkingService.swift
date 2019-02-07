//
//  NetworkingService.swift
//  TransactionZ
//
//  Created by André Vellori on 07/02/2019.
//  Copyright © 2019 André Vellori. All rights reserved.
//

import Foundation

struct NetworkingService {
    let client: Networking
    
    init(client: Networking = URLSession.shared) {
        self.client = client
    }
    
    @discardableResult func get<Model: Decodable & DecoderProvider>(url: URL, callback: @escaping (Result<Model>) -> ()) -> Cancellable {
        let request = URLRequest(url: url)
        return client.perform(request: request) { (response) in
            let result = Result<Model>.with(response: response)
            DispatchQueue.main.async {
                callback(result)
            }
        }
        
    }
}
