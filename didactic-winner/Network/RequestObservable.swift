//
//  RequestObservable.swift
//  didactic-winner
//
//  Created by Martin Mungai on 30/06/2021.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa

final class RequestObservable {
    
    // MARK: - Private Instance Properties
    private lazy var decoder = JSONDecoder()
    private var urlSession: URLSession
    
    // MARK: - Public Initializer
    public init(config: URLSessionConfiguration) {
        self.urlSession = .init(configuration: .default)
    }
    
    // MARK: - Instance Methods
    
    public func fetchDataModel<Model: Codable>(request: URLRequest) -> Observable<Model> {
        return urlSession.rx.data(request: request).map { (data) in
            return try self.decoder.decode(Model.self, from: data)
        }
    }
    
    public func fetchImage(request: URLRequest) -> Observable<ImageResponse> {
        return urlSession.rx.data(request: request).map { (data) in
            return ImageResponse(from: data)
        }
    }
}
