//
//  HomeViewControllerTests.swift
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


class HomeControllerTests: XCTestCase {
    
    func test_DidLoadView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: HomeViewController.className) as! HomeViewController
        sut.loadViewIfNeeded()
        
        let numberOfItems = sut.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfItems, 0)
        
        let numberOfSections = sut.tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 1)
    }
}

