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

final class APIClient {
    
    static var shared = APIClient()
    lazy var requestObservable = RequestObservable(config: .default)
    
    func getImagesData() throws -> Observable<ImagesResponse> {
        var request = URLRequest(url: URL(string: "https://images-api.nasa.gov/search?q=%22%22")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return requestObservable.callAPI(request: request)
    }
    
    func fetchImage(url: URL) throws -> Observable<ImageResponse> {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return requestObservable.fetchImage(url: url, store: delegate.imageStore)
    }
}
