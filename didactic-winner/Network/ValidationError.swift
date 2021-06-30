//
//  ValidationError.swift
//  didactic-winner
//
//  Created by Martin Mungai on 30/06/2021.
//

import Foundation

enum ValidationError: Error {
    case missingImage
    case missingImageData
    case missingResponse
}

extension ValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingImage:
            return NSLocalizedString("Missing Image", comment: "")
        case .missingImageData:
            return NSLocalizedString("Missing Image Data", comment: "")
        case .missingResponse:
            return NSLocalizedString("Missing Response", comment: "")
        }
    }
}
