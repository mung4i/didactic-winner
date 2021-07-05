//
//  APIClient.swift
//  didactic-winner
//
//  Created by Martin Mungai on 30/06/2021.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa

protocol APIContract {
    func getImagesData() -> Observable<ImagesResponse>
    func fetchImage(url: URL) -> Observable<ImageResponse>
}

final class APIClient: APIContract {
    
    static var shared = APIClient()
    lazy var requestObservable = RequestObservable(config: .default)
    
    var isLoading: BehaviorRelay<Bool> {
        requestObservable.isLoadingDataModel
    }
    
    var isLoadingImage: BehaviorRelay<Bool> {
        requestObservable.isLoadingImage
    }
    
    func getImagesData() -> Observable<ImagesResponse> {
        var request = URLRequest(url: URL(string: "https://images-api.nasa.gov/search?q=%22%22")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return requestObservable.fetchDataModel(request: request)
    }
    
    func fetchImage(url: URL) -> Observable<ImageResponse> {
        return requestObservable.fetchImage(request: URLRequest(url: url))
    }
}

extension APIClient {
    var store: ImageStore {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.imageStore
    }
}
