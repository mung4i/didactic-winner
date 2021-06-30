//
//  BaseViewModel.swift
//  didactic-winner
//
//  Created by Martin Mungai on 30/06/2021.
//

import Foundation

import RxSwift
import RxCocoa

class BaseViewModel {
    let disposeBag = DisposeBag()
    
    private let error: BehaviorRelay<String> = .init(value: "")
    private let isLoading: BehaviorRelay<Bool> = .init(value: false)
    private let collection: BehaviorRelay<[Item]> = .init(value: [])
    
    func bind() -> (
        collection: Observable<[Item]>,
        error: Observable<String>,
        isLoading: Observable<Bool>
    ) {
        return (
            collection: self.collection.asObservable(),
            error: self.error.asObservable(),
            isLoading: self.isLoading.asObservable()
        )
    }
    
    func fetchImages() {
        isLoading.accept(true)
        do {
            try APIClient.shared.getImagesData().subscribe(
                onNext: { result in
                    self.collection.accept(result.collection.items)
                    self.isLoading.accept(false)
                },
                onError: { error in
                    self.error.accept(error.localizedDescription)
                    self.isLoading.accept(false)
                },
                onCompleted: {
                    self.isLoading.accept(false)
                }
            ).disposed(by: disposeBag)
            
        } catch {
            self.error.accept(error.localizedDescription)
            self.isLoading.accept(false)
        }
    }
    
    init() {
        self.fetchImages()
    }
}
