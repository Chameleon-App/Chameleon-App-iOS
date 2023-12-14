//
//  DateService.swift
//  chameleon
//
//  Created by Ilia Chub on 15.12.2023.
//

import Foundation

final class DateService {
    enum Constants {
        static let backendDateFormat = "yyyy-MM-dd"
    }
    
    enum DateFormats {
        case monthAndDate
        case custom(format: String)
    }
    
    static func getFormattedDate(date: Date, format: DateFormats) -> String? {
        switch format {
        case .monthAndDate:
            return getCustomDate(date: date, format: "MMM. dd")
        case .custom(let format):
            return getCustomDate(date: date, format: format)
        }
    }
    
    static func getFormattedDate(timeInterval: TimeInterval, format: DateFormats) -> String? {
        let date = Date(timeIntervalSince1970: timeInterval)
        
        return getFormattedDate(date: date, format: format)
    }
    
    static private func getCustomDate(date: Date, format: String) -> String? {
        let formatter = getDateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    static private func getDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        
        return dateFormatter
    }
}
