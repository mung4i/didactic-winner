//
//  ItemTableViewCell.swift
//  didactic-winner
//
//  Created by Martin Mungai on 30/06/2021.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa

class ItemTableViewCell: UITableViewCell {
    // MARK: - Private Instance Properties
    private let disposeBag = DisposeBag()
    
    // MARK: - IB Outlets
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellDetailLabel: UILabel!
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    // MARK: - Overriden Instance Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        APIClient.shared.isLoadingImage.asObservable().subscribe { event in
            let isLoading = event.element ?? false
            
            if isLoading {
                self.cellImageView.addBlurView()
            } else {
                self.cellImageView.removeBlurView()
            }
        }.disposed(by: disposeBag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView.image = nil
    }
    
    // MARK: - IB Outlets
    func populateData(item: Item) {
        cellDetailLabel.text = item.detail
        cellTitleLabel.text = item.title
        
        guard let link = item.link else { return }
        setImage(urlString: link)
    }
    
    // MARK: - Private Instance Methods
    private func bindImageView(url: URL) {
         APIClient.shared.fetchImage(url: url).subscribe { (event) in
            guard let image = event.element?.image else { return }
            DispatchQueue.main.async {
                APIClient.shared.store.saveImage(image: image, url: url)
                self.cellImageView.image = image.resizeImg()
                self.setNeedsLayout()
            }
        }.disposed(by: disposeBag)
    }
    
    private func setImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        if let image = APIClient.shared.store.image(url: url) {
            cellImageView.image = image.resizeImg()
        } else {
            self.bindImageView(url: url)
        }
    }
}
