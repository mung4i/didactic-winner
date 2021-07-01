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
