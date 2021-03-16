//
//  Extension.swift
//  
//
//  Created by Kevin Wood on 3/16/21.
//

import Foundation

extension Date {

    private var startOfMonth: Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)
        return  calendar.date(from: components)!
    }

    private func endOfMonth(months: Int, days: Int) -> Date {
        var components = DateComponents()
        components.month = months
        components.day = days
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }
    
    var isTwoWeeksIn: Bool {
        return self == endOfMonth(months: 1, days: -15)
    }
    
    var isLastDate: Bool {
        return self == endOfMonth(months: 1, days: -1)
    }
}
