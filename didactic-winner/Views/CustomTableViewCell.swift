//
//  CustomTableViewCell.swift
//  didactic-winner
//
//  Created by Martin Mungai on 30/06/2021.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa

class CustomTableViewCell: UITableViewCell {
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellDetailLabel: UILabel!
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    func populateData(item: Item) {
        guard let data = item.data.first else { return }
        
        let detail = data.photographer == nil ? "" : "\(data.photographer ?? "") | \(formattedDate(created: data.dateCreated))"

        cellDetailLabel.text = detail
        cellTitleLabel.text = data.title
        
        guard let link = item.links.first?.href else { return }
        setImage(urlString: link)
    }
    
    private func formattedDate(created: String) -> String{
        return Date.formatDate(str: created)
    }
    
    private func setImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        try? APIClient.shared.fetchImage(url: url).subscribe { (event) in
            guard let imageResponse = event.element else { return }
            DispatchQueue.main.async {
                self.cellImageView.image = imageResponse.image?.resizeImg()
                self.setNeedsLayout()
            }
        }.disposed(by: disposeBag)
    }
}

extension Date {
    static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale.current
        return dateFormatter
    }
    
    static func formatDate(str: String, format: String = "d MMM YYYY") -> String {
        if let date = Date.dateFormatter.date(from: str) {
            let newDf = DateFormatter()
            newDf.dateFormat = format
            return newDf.string(from: date)
        }
        return ""
    }
}


extension UIImage {
    func resizeImg(
        toSize size: CGSize = CGSize(width: 64, height: 64),
        scale: CGFloat = UIScreen.main.scale
    ) -> UIImage? {
        let imgRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: imgRect)
        let resizedImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resizedImg
    }
}
