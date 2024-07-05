//
//  DateFormatterManager.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 26.06.2024.
//

import Foundation

class DateFormatterManager {
    static let shared = DateFormatterManager()

    private init() {}

    func dateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM yyyy"
        return dateFormatter
    }
    
    func getDay() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d"
        return dateFormatter
    }
    
    func getMonth() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter
    }
}
