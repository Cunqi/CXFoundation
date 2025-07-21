//
//  File.swift
//  CXFoundation
//
//  Created by Cunqi Xiao on 7/13/25.
//

import Foundation

extension Date {
    public var abbreviatedMonth: String {
        DateFormatter.abbreviatedMonth.string(from: self)
    }

    public var dayOfWeekWithMonthAndDay: String {
        DateFormatter.dayOfWeekWithMonthAndDay.string(from: self)
    }

    public var fullMonth: String {
        DateFormatter.fullMonth.string(from: self)
    }

    public var year: String {
        DateFormatter.year.string(from: self)
    }

    public var day: String {
        DateFormatter.day.string(from: self)
    }

    public var fullDate: String {
        DateFormatter.fullDate.string(from: self)
    }

    public var monthDay: String {
        DateFormatter.monthDay.string(from: self)
    }
}

extension DateFormatter {
    static var abbreviatedMonth: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter
    }

    static var dayOfWeekWithMonthAndDay: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter
    }

    static var fullMonth: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }

    static var fullDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter
    }

    static var year: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }

    static var day: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }

    static var monthDay: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter
    }
}
