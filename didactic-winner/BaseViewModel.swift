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
    
    let isLoading: BehaviorRelay<Bool> = .init(value: false)
}
