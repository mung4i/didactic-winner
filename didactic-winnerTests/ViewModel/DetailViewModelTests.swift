//
//  DetailViewModelTests.swift
//  didactic-winnerTests
//
//  Created by Martin Mungai on 05/07/2021.
//

import XCTest
@testable import didactic_winner

class DetailsViewModelTests: BaseAPIClientTests {
    var detailSpy: DetailsSpy!
    
    override func setUp() {
        super.setUp()
        
        self.detailSpy = DetailsSpy()
    }
    
    func test_DidInitializeViewModel() {
        guard let item = self.spy.value.first else {
            XCTFail(ValidationError.missingImageData.localizedDescription)
            return
        }
        
        let viewModel = DetailViewModel(item: item)
        let output = viewModel.bind()
        
        XCTAssertNotEqual(output.descLabel.value, "")
        
        self.detailSpy.setValue(observable: output.subtitleLabel)
        XCTAssertEqual(self.detailSpy.value, "Tom Trower | 20 Mar 2002")
        
        self.detailSpy.setValue(observable: output.titleLabel)
        XCTAssertEqual(self.detailSpy.value, "ARC-2002-ACD02-0056-22")
        
        XCTAssertNotEqual(output.descLabel.value, "")
    }
}

