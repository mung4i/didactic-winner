//
//  UIKit+.swift
//  didactic-winner
//
//  Created by Martin Mungai on 30/06/2021.
//

import UIKit

extension CGSize {
    public static func customHeight(_ defaultSize: CGFloat) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        let baseWidth: CGFloat = 812
        return defaultSize * (height / baseWidth)
    }
    
    public static func customWidth(_ defaultSize: CGFloat) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        
        let baseWidth: CGFloat = 375
        return defaultSize * (width / baseWidth)
    }
}

extension UIColor {
    static func color(hex:String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UIImage {
    public convenience init?(
        color: UIColor,
        size: CGSize = CGSize(width: 1, height: 1)
    ) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
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

extension UIView {
    func _addBlurView() {
        let effectView = UIBlurEffect(style: .light)
        
        let blurView = UIVisualEffectView(effect: effectView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseInOut, animations: {
            self.addSubview(blurView)
        })
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = UIColor.black
        activityIndicator.style = .gray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        blurView.contentView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            blurView.widthAnchor.constraint(equalToConstant: 150),
            blurView.heightAnchor.constraint(equalToConstant: 150),
            blurView.centerXAnchor.constraint(equalTo: centerXAnchor),
            blurView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: blurView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: blurView.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            activityIndicator.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25)
        ])
        
        blurView.layer.cornerRadius = 5
        blurView.layer.masksToBounds = true
        
        activityIndicator.startAnimating()
    }
    
    func _removeBlurView() {
        subviews.forEach { (view) in
            guard view.isKind(of: UIVisualEffectView.self) else { return }
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseInOut, animations: {
                view.removeFromSuperview()
            })
        }
    }
    
    func addBlurView() {
        DispatchQueue.main.async {
            self._addBlurView()
        }
    }
    
    func removeBlurView() {
        DispatchQueue.main.async {
            self._removeBlurView()
        }
    }
}

extension UIViewController {
    func addBlurView() {
        DispatchQueue.main.async {
            self.view.addBlurView()
        }
    }
    
    func removeBlurView() {
        DispatchQueue.main.async {
            self.view.removeBlurView()
        }
    }
    
    func showControllerAlert(message: String, title: String, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self._showControllerAlert(message: message, title: title, completion: completion)
        }
    }
    
    func _showControllerAlert(message: String, title: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "OK", style: .default) { _ in
                if let completion = completion { completion() }
            }
        )
        self.present(alert, animated: true, completion: nil)
    }
}
