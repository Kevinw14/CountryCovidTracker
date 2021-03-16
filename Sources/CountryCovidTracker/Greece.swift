//
//  Greece.swift
//  
//
//  Created by Kevin Wood on 3/15/21.
//

import Foundation

class Country: Codable {
    let greece: Greece
    
    enum CodingKeys: String, CodingKey {
        case greece = "GRC"
    }
}

class Greece: Codable {
    
    var stats: [Stat]
    
    enum CodingKeys: String, CodingKey {
        case stats = "data"
    }
}

class Stat: Codable, Equatable {
    let totalCases: Int
    private let dateString: String
    var date: Date {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let date: Date = dateFormatter.date(from: dateString)!
        return date
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dateString = try container.decode(String.self, forKey: .dateString)
        self.totalCases = try container.decodeIfPresent(Int.self, forKey: .totalCases) ?? 0
    }
    
    enum CodingKeys: String, CodingKey {
        case totalCases = "total_cases"
        case dateString = "date"
    }
    
    static func ==(lhs: Stat, rhs: Stat) -> Bool {
            lhs.date == rhs.date &&
                lhs.totalCases == rhs.totalCases
        }
}
