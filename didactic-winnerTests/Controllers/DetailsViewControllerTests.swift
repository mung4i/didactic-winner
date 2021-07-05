//
//  DetailsViewControllerTests.swift
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

class DetailsViewControllerTests: XCTestCase {
    
    func test_DidLoadDetailsView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: DetailsViewController.className) as! DetailsViewController
        sut.loadViewIfNeeded()
        
        XCTAssertNil(sut.imageView.image)
        XCTAssertEqual(sut.descLabel.text, "")
        XCTAssertEqual(sut.subtitleLabel.text, "")
        XCTAssertEqual(sut.titleLabel.text, "")
    }
}
