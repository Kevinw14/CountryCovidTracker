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
        components.day = -days
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }
    
    var twoWeeksInMonth: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.string(from: endOfMonth(months: 1, days: 1))
        if dayOfWeek == "Sunday" {
            return endOfMonth(months: 1, days: 3)
        } else if dayOfWeek == "Saturday" {
            return endOfMonth(months: 1, days: 2)
        }
        
        return endOfMonth(months: 1, days: 1)
    }
    
    var isTwoWeeksIn: Bool {
        return self == endOfMonth(months: 1, days: 15)
    }
    
    var isLastDate: Bool {
        return self == endOfMonth(months: 1, days: 1)
    }
}
