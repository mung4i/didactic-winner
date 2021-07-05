//
//  HomeViewModelTests.swift
//  didactic-winnerTests
//
//  Created by Martin Mungai on 05/07/2021.
//

import XCTest
@testable import didactic_winner

class HomeViewModelTests: BaseAPIClientTests {
    var detailSpy: DetailsSpy!
    
    override func setUp() {
        super.setUp()
        self.detailSpy = DetailsSpy()
    }
    
    override func tearDown() {
        super.tearDown()
        self.detailSpy = nil
    }
    
    func test_DidInitializeViewModel() {
        
        let viewModel = HomeViewModel()
        viewModel.collection.accept(self.spy.value)
        
        XCTAssertEqual(viewModel.collection.value.count, 100)
        
        let output = viewModel.bind()
        self.detailSpy.setValue(observable: output.title)
        XCTAssertEqual(self.detailSpy.value, "The Milky Way")
        
    }
}
