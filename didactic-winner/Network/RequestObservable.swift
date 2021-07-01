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
    var isLoadingDataModel: BehaviorRelay<Bool> = .init(value: false)
    var isLoadingImage: BehaviorRelay<Bool> = .init(value: false)
    
    // MARK: - Public Initializer
    public init(config: URLSessionConfiguration) {
        self.urlSession = .init(configuration: .default)
    }
    
    // MARK: - Instance Methods
    
    public func fetchDataModel<Model: Codable>(request: URLRequest) -> Observable<Model> {
        isLoadingDataModel.accept(true)
        return urlSession.rx.data(request: request).map { (data) in
            self.isLoadingDataModel.accept(false)
            return try self.decoder.decode(Model.self, from: data)
        }
    }
    
    public func fetchImage(request: URLRequest) -> Observable<ImageResponse> {
        isLoadingImage.accept(true)
        return urlSession.rx.data(request: request).map { (data) in
            self.isLoadingImage.accept(false)
            return ImageResponse(from: data)
        }
    }
}
