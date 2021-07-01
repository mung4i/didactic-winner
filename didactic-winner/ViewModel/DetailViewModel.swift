//
//  DetailViewModel.swift
//  didactic-winner
//
//  Created by Martin Mungai on 01/07/2021.
//

import Foundation
import RxCocoa
import RxSwift

class DetailViewModel {
    private let item: Item
    
    init(item: Item) {
        self.item = item
    }
    
    func bind() -> (
        descLabel: BehaviorRelay<String>,
        subtitleLabel: Driver<String>,
        titleLabel: Driver<String>,
        urlString: BehaviorRelay<String>
    ) {
        return (
            descLabel: .init(value: item.description),
            subtitleLabel: .just(item.detail),
            titleLabel: .just(item.title),
            urlString: .init(value: item.link ?? "")
        )
    }
}
