//
//  ImageCache.swift
//  didactic-winner
//
//  Created by Martin Mungai on 30/06/2021.
//

import Foundation
import UIKit

protocol ImageCache {
    func image(url: URL) -> UIImage?
    func saveImage(image: UIImage?, url: URL)
}

class ImageStore: ImageCache {
    var cache: Dictionary<String, UIImage> = .init()
    
    func image(url: URL) -> UIImage? {
        return cache[url.absoluteString]
    }
    
    func saveImage(image: UIImage?, url: URL) {
        if let image = image {
            cache[url.absoluteString] = image
        }
    }    
}
