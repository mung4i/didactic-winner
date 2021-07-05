//
//  DetailSpy.swift
//  didactic-winnerTests
//
//  Created by Martin Mungai on 05/07/2021.
//

import RxCocoa
import RxSwift

class DetailsSpy {
    private let disposeBag = DisposeBag()
    private(set) var value: String = ""
    
    func setValue(observable: Driver<String>) {
        observable.asObservable().subscribe {
            if let element = $0.element {
                self.value = element
            }
        }.disposed(by: disposeBag)
    }
}
