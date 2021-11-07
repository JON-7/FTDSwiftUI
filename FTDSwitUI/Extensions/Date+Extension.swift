//
//  Date+Extension.swift
//  FTDSwitUI
//
//  Created by Jon E on 11/6/21.
//

import Foundation

extension Date {
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }

    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    var toString: String {
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let stringDate = newFormatter.string(from: self)
        return stringDate + ".000Z"
    }
}
