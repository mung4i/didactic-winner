//
//  APIClientSpy.swift
//  didactic-winnerTests
//
//  Created by Martin Mungai on 05/07/2021.
//

import XCTest
@testable import didactic_winner

import RxCocoa
import RxSwift

class APIClientSpy {
    private let disposeBag = DisposeBag()
    private(set) var imageValue: ImageResponse?
    private(set) var value: [Item] = []
    
    init(observable: Observable<ImagesResponse>) {
        observable.subscribe { (event) in
            if let element = event.element {
                self.value = element.collection.items
            }
        }.disposed(by: disposeBag)
    }
    
    func imageValue(observable: Observable<ImageResponse>) {
        observable.subscribe { (event) in
            if let element = event.element {
                self.imageValue = element
            }
        }.disposed(by: disposeBag)
    }
}
