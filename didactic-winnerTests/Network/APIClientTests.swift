//
//  APIClientTests.swift
//  didactic-winnerTests
//
//  Created by Martin Mungai on 05/07/2021.
//

import XCTest
@testable import didactic_winner

import RxCocoa
import RxSwift
import RxTest
import RxBlocking

class BaseAPIClientTests: XCTestCase {
    var apiClientStub: APIContract!
    var data: Observable<ImagesResponse>!
    var spy: APIClientSpy!
    
    override func setUp() {
        super.setUp()
        
        apiClientStub = APIClientStub.shared
        data = self.apiClientStub.getImagesData()
        spy = APIClientSpy(observable: self.data)
    }
    
    override func tearDown() {
        super.tearDown()
        
        apiClientStub = nil
        data = nil
        spy = nil
    }
}

class APIClientTests: BaseAPIClientTests {
        
    func test_DidFetchData() {
        XCTAssertEqual(spy.value.count, 100)
    }
    
    func test_DidFetchImage() {
        guard let link = self.spy.value.first?.link else {
            XCTFail(ValidationError.missingImage.localizedDescription)
            return
        }
        
        let url = URL(string: link)!
        let data = apiClientStub.fetchImage(url: url)
        self.spy.imageValue(observable: data)
        
        XCTAssertNotNil(self.spy.imageValue)
    }
}
