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
    
    func getDay(dateString: String) -> Int? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM yyyy"
        if let date = formatter.date(from: dateString) {
            let day = Calendar.current.component(.day, from: date)
            return day
        }
        return nil
    }
    
    func getMonth(dateString: String) -> String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM yyyy"
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "MMMM"
            let monthName = formatter.string(from: date)
            return monthName
        }
        return nil
    }
}
