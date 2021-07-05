//
//  APIClientStub.swift
//  didactic-winnerTests
//
//  Created by Martin Mungai on 05/07/2021.
//

import XCTest
@testable import didactic_winner

import RxCocoa
import RxSwift

class APIClientStub: APIContract {
    static var shared: APIContract = APIClientStub()
    
    func getImagesData() -> Observable<ImagesResponse> {
        let testBundle = Bundle(for: type(of: self))
        let url = testBundle.url(forResource: "Collection", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return .just(try! JSONDecoder().decode(ImagesResponse.self, from: data))
    }
    
    func fetchImage(url: URL) -> Observable<ImageResponse> {
        return .just(ImageResponse(from: Data()))
    }
}
