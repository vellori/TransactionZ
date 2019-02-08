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
    var networking: Networking
    
    init(networking: Networking = URLSession.shared) {
        self.networking = networking
    }
    
    deinit {
        task?.cancel()
    }
    
    func imageFromCache(url: URL) -> UIImage? {
        return ImageLoader.imageCache.object(forKey: url as NSURL)
    }
    
    func storeImageInCache(url: URL, image: UIImage) {
        ImageLoader.imageCache.setObject(image, forKey: url as NSURL)
    }
    
    func get(url: URL, in imageView: UIImageView) {
        if let image = imageFromCache(url: url) {
            imageView.image = image
            return
        }
        let request = URLRequest(url: url)
        task = networking.perform(request: request, callback: { [weak self] (response) in
            guard response.error == nil,
                let data = response.data else {
                    return
            }
            if let image = UIImage(data: data) {
                self?.storeImageInCache(url: url, image: image)
                DispatchQueue.main.async {
                    imageView.image = image
                    objc_setAssociatedObject(imageView, ImageLoader.identifier, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                }
            }
        })
        objc_setAssociatedObject(imageView, ImageLoader.identifier, self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
