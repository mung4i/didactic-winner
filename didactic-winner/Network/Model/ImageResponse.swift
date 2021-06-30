//
//  ImageResponse.swift
//  didactic-winner
//
//  Created by Martin Mungai on 30/06/2021.
//

import Foundation
import UIKit

public struct ImageResponse: Codable {
    let data: Data
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let data = try container.decode(Data.self)
        self.data = data
    }
    
    init(from data: Data) {
        self.data = data
    }
}

extension ImageResponse {
    var image: UIImage? {
        return UIImage(data: data)
    }
}
