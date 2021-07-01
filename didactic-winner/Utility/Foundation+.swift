//
//  Foundation+.swift
//  didactic-winner
//
//  Created by Martin Mungai on 30/06/2021.
//

import Foundation

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

extension String {
    var formattedDate: String {
        return Date.formatDate(str: self)
    }
}

public protocol ClassName {
    static var className: String { get }
    var className: String { get }
}

public extension ClassName {
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassName {}
