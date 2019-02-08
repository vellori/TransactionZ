//
//  ImageLoader.swift
//  TransactionZ
//
//  Created by André Vellori on 07/02/2019.
//  Copyright © 2019 André Vellori. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC

class ImageLoader {
    static let identifier = "imageLoad"
    static let imageCache = NSCache<NSURL, UIImage>()
    var task: Cancellable?
    
    deinit {
        task?.cancel()
    }
    
    func get(url: URL, in imageView: UIImageView, networking: Networking = URLSession.shared) {
        if let image = ImageLoader.imageCache.object(forKey: url as NSURL) {
            imageView.image = image
            print("Cache")
            return
        }
        let request = URLRequest(url: url)
        task = networking.perform(request: request, callback: { (response) in
            guard response.error == nil,
                let data = response.data else {
                    return
            }
            if let image = UIImage(data: data) {
                ImageLoader.imageCache.setObject(image, forKey: url as NSURL)
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        })
        objc_setAssociatedObject(self, ImageLoader.identifier, self, .OBJC_ASSOCIATION_RETAIN)
    }
}
