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
    let error: BehaviorRelay<String> = .init(value: "")
    let isLoading: BehaviorRelay<Bool> = .init(value: false)
    let collection: BehaviorRelay<[Item]> = .init(value: [])
    
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
}
