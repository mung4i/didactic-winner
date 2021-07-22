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
    @IBOutlet weak var descLabel: UITextView!
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
            output.subtitleLabel.drive(subtitleLabel.rx.text),
            output.titleLabel.drive(titleLabel.rx.text)
        )
        
        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = 1.57
        
        descLabel.attributedText = NSAttributedString(
            string: output.descLabel.value,
            attributes: [NSAttributedString.Key.paragraphStyle : style]
        )
    }
    
    func setImage(viewModel: DetailViewModel) {
        let output = viewModel.bind()
        guard let url = URL(string: output.urlString.value) else { return }
        
        let size: CGSize = .init(
            width: CGSize.customWidth(imageView.bounds.width),
            height: CGSize.customHeight(imageView.bounds.height)
        )
        
        if let image = APIClient.shared.store.image(url: url) {
            imageView.image = image
        } else {
            bindImageView(url: url)
        }
    }
    
    private func bindImageView(url: URL) {
        APIClient.shared.isLoadingImage.asObservable().subscribe { event in
            let isLoading = event.element ?? false
            if isLoading {
                self.imageView.addBlurView()
            } else {
                self.imageView.removeBlurView()
            }
        }.disposed(by: disposeBag)
        
         APIClient.shared.fetchImage(url: url).subscribe { (event) in
            guard let image = event.element?.image else { return }
            DispatchQueue.main.async {
                APIClient.shared.store.saveImage(image: image, url: url)
                self.imageView.image = image
                self.view.setNeedsLayout()
            }
        }.disposed(by: disposeBag)
    }
}

