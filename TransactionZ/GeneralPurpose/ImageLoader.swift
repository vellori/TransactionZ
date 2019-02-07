//
//  ImageLoader.swift
//  TransactionZ
//
//  Created by André Vellori on 07/02/2019.
//  Copyright © 2019 André Vellori. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader {
    static var networkingService: Networking = URLSession.shared
    static var references = [UIImageView: Cancellable]()
    static func get(url: URL, in imageView: UIImageView) {
        references[imageView]?.cancel()
        let request = URLRequest(url: url)
        references[imageView] = networkingService.perform(request: request, callback: { (response) in
            guard response.error == nil,
                let data = response.data else {
                    return
            }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                imageView.image = image
                references[imageView] = nil
            }
        })
    }
}
