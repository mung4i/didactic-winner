//
//  HomeViewModel.swift
//  didactic-winner
//
//  Created by Martin Mungai on 30/06/2021.
//

import Foundation

import RxSwift
import RxCocoa

class HomeViewModel {
    let disposeBag = DisposeBag()
    
    private let error: BehaviorRelay<String> = .init(value: "")
    let collection: BehaviorRelay<[Item]> = .init(value: [])
    private let title: String = "The Milky Way"
    
    func bind() -> (
        collection: Observable<[Item]>,
        error: Observable<String>,
        isLoading: Observable<Bool>,
        title: Driver<String>
    ) {
        return (
            collection: self.collection.asObservable(),
            error: self.error.asObservable(),
            isLoading: APIClient.shared.isLoading.asObservable(),
            title: .just(self.title)
        )
    }
    
    func fetchImagesModel() {
        APIClient.shared.getImagesData().subscribe { event in
            guard let items = event.element?.collection.items else {
                self.error.accept(ValidationError.missingImageData.localizedDescription)
                return
            }
            self.collection.accept(items)
        }.disposed(by: disposeBag)
    }
    
    init() {
        self.fetchImagesModel()
    }
}
