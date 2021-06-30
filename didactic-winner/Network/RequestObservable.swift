//
//  RequestObservable.swift
//  didactic-winner
//
//  Created by Martin Mungai on 30/06/2021.
//

import Foundation
import RxSwift
import RxCocoa

final class RequestObservable {
    
    private lazy var decoder = JSONDecoder()
    private var urlSession: URLSession
    
    public init(config: URLSessionConfiguration) {
        self.urlSession = .init(configuration: .default)
    }
    
    public func callAPI<Model: Codable>(request: URLRequest) -> Observable<Model> {
        return Observable.create { (observer) in
            
            let task = self.urlSession.dataTask(with: request) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    do {
                        let fetchedData = data ?? Data()
                        
                        if (200...399).contains(httpResponse.statusCode) {
                            let imagesResponse = try self.decoder.decode(Model.self, from: fetchedData)
                            observer.onNext(imagesResponse)
                        } else {
                            observer.onError(error!)
                        }
                    }
                    catch {
                        observer.onError(error)
                    }
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
