//
//  DetailViewController.swift
//  didactic-winner
//
//  Created by Martin Mungai on 01/07/2021.
//

import UIKit

import RxCocoa
import RxSwift

class DetailsViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: DetailViewModel?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let vm = self.viewModel {
            self.bindLabels(viewModel: vm)
            self.setImage(viewModel: vm)
        }
    }
    
    
    func bind(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    func bindLabels(viewModel: DetailViewModel) {
        let output = viewModel.bind()
        
        disposeBag.insert(
            output.descLabel.drive(descLabel.rx.text),
            output.subtitleLabel.drive(subtitleLabel.rx.text),
            output.titleLabel.drive(titleLabel.rx.text)
        )
    }
    
    func setImage(viewModel: DetailViewModel) {
        let output = viewModel.bind()
        guard let url = URL(string: output.urlString.value) else { return }
        if let image = APIClient.shared.store.image(url: url) {
            let size: CGSize = .init(
                width: CGSize.customWidth(375),
                height: CGSize.customHeight(230)
            )
            imageView.image = image.resizeImg(toSize: size)
        }
    }
}




