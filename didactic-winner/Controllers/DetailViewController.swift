//
//  DetailViewController.swift
//  didactic-winner
//
//  Created by Martin Mungai on 01/07/2021.
//

import UIKit

import RxCocoa
import RxSwift

class DetailViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: DetailViewModel?
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    func bind(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        let output = viewModel.bind()
        
        disposeBag.insert(
            output.descLabel.drive(descLabel.rx.text),
            output.subtitleLabel.drive(subtitleLabel.rx.text),
            output.titleLabel.drive(titleLabel.rx.text)
        )
    }
}

class DetailViewModel {
    private let item: Item
    
    init(item: Item) {
        self.item = item
    }
    
    func bind() -> (
        descLabel: Driver<String>,
        subtitleLabel: Driver<String>,
        titleLabel: Driver<String>
    ) {
        return (
            descLabel: .just(item.description),
            subtitleLabel: .just(item.detail),
            titleLabel: .just(item.title)
        )
    }
}
