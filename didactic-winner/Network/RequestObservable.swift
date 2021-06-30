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
    public func callAPI<Model: Codable>(request: URLRequest) -> Observable<Model> {
        return Observable.create { (observer) in
            
            let task = self.urlSession.dataTask(with: request) { (data, response, error) in
                guard let httpResponse = response as? HTTPURLResponse else {
                    observer.onError(ValidationError.missingResponse)
                    return
                }
                do {
                    let fetchedData = data ?? Data()
                    if (200...399).contains(httpResponse.statusCode) {
                        let imagesResponse = try self.decoder.decode(Model.self, from: fetchedData)
                        observer.onNext(imagesResponse)
                    } else {
                        observer.onError(error!)
                    }
                }
                catch { observer.onError(error) }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    public func fetchImage(url: URL, store: ImageStore) -> Observable<ImageResponse> {
        return Observable.create { (observer) in
            if let image = store.image(url: url) {
                observer.onNext(ImageResponse(from: image.pngData() ?? .init()))
                observer.onCompleted()
            } else {
                self.executeRequest(url: url) { (result) in
                    switch result {
                    case .failure(let error):
                        observer.onError(error)
                    case .success(let imgResponse):
                        store.saveImage(image: imgResponse.image, url: url)
                        observer.onNext(imgResponse)
                        observer.onCompleted()
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    // MARK: - Private Instance Methods
    private func executeRequest(url: URL, completion: @escaping (Result<ImageResponse, Error>) -> Void) {
        let request = URLRequest(url: url)
        let task = self.urlSession.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(ValidationError.missingResponse))
                return
            }
            guard (200...399).contains(httpResponse.statusCode) else {
                completion(.failure(ValidationError.missingImage))
                return
            }
            guard let data = data else {
                completion(.failure(ValidationError.missingImageData))
                return
            }
            completion(.success(ImageResponse(from: data)))
        }
        task.resume()
    }
    
    private func getImage(request: URLRequest) -> Observable<ImageResponse> {
        return callAPI(request: request)
    }
}
