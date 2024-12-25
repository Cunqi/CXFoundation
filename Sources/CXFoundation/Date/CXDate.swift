//
//  CXDate.swift
//  CXFoundation
//
//  Created by Cunqi Xiao on 12/16/24.
//

import Foundation

/// A struct representing a complete date with year, month, and day components.
///
/// This struct provides a convenient way to work with dates by breaking them down into
/// individual components (year, month, day) while maintaining the original `Date` value.
/// It supports validation of the entire date as well as individual components.
public struct CXDate: CXDateComponent {

    // MARK: - Constants

    public enum DateComponentType: CaseIterable {
        case year
        case month
        case day
    }

    // MARK: - Public properties

    /// The calendar used for date calculations.
    public let calendar: Calendar

    /// The year component of the date.
    public var year: CXDateComponentYear

    /// The month component of the date.
    public var month: CXDateComponentMonth {
        didSet {
            year = month.year
        }
    }

    /// The day component of the date.
    public var day: CXDateComponentDay {
        didSet {
            month = day.month
        }
    }

    /// The underlying Foundation Date value.
    public var value: Date {
        var components = DateComponents()
        if year.isValid {
            components.year = year.value
        }
        if month.isValid {
            components.month = month.value
        }
        if day.isValid {
            components.day = day.value
        }
        return calendar.date(from: components) ?? .now
    }

    /// The unique identifier of the date.
    public var id: String {
        description
    }

    /// The formatted string representation of the date.
    public var formattedValue: String {
        formatter.string(from: value)
    }

    /// Returns `true` if any of the components (year, month, day) are valid.
    public var isValid: Bool {
        year.isValid || (year.isValid && month.isValid) || (year.isValid && month.isValid && day.isValid)
    }

    /// A string representation of the date in "yyyy-MM-dd" format.
    public var description: String {
        if year.isValid && month.isValid && day.isValid {
            return year.description + "-" + month.description + "-" + day.description
        } else if year.isValid && month.isValid {
            return year.description + "-" + month.description
        } else if year.isValid {
            return year.description
        } else {
            return .placeholder
        }
    }

    // MARK: - Private properties

    /// The date formatter used for string conversion.
    private let formatter: DateFormatter

    // MARK: - Initializers

    public init(formatter: DateFormatter? = nil) {
        self.year = .empty
        self.month = .empty
        self.day = .empty
        self.calendar = .current
        self.formatter = formatter ?? CXDate.defaultFormatter()
    }

    /// Creates a date from a Foundation Date object.
    /// - Parameters:
    ///   - date: The Foundation Date to create from.
    ///   - calendar: The calendar to use for date calculations (defaults to current).
    ///   - formatter: Optional custom date formatter (defaults to "yyyy-MM-dd" format).
    public init(_ date: Date, calendar: Calendar = .current, formatter: DateFormatter? = nil) {
        self.day = CXDateComponentDay(date, calendar: calendar)
        self.month = day.month
        self.year = day.month.year
        self.calendar = calendar
        self.formatter = formatter ?? CXDate.defaultFormatter()
    }

    public init(day: CXDateComponentDay, calendar: Calendar = .current, formatter: DateFormatter? = nil) {
        self.day = day
        self.month = day.month
        self.year = day.month.year
        self.calendar = calendar
        self.formatter = formatter ?? CXDate.defaultFormatter()
    }

    public init(month: CXDateComponentMonth, calendar: Calendar = .current, formatter: DateFormatter? = nil) {
        self.month = month
        self.year = month.year
        self.day = .empty
        self.calendar = calendar
        self.formatter = formatter ?? CXDate.defaultFormatter()
    }

    public init(year: CXDateComponentYear, calendar: Calendar = .current, formatter: DateFormatter? = nil) {
        self.year = year
        self.month = .empty
        self.day = .empty
        self.calendar = calendar
        self.formatter = formatter ?? CXDate.defaultFormatter()
    }

    // MARK: - Equatable

    public static func == (lhs: CXDate, rhs: CXDate) -> Bool {
        lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
    }

    // MARK: - Comparable

    public static func < (lhs: CXDate, rhs: CXDate) -> Bool {
        if lhs.year != rhs.year {
            return lhs.year < rhs.year
        }
        if lhs.month != rhs.month {
            return lhs.month < rhs.month
        }
        return lhs.day < rhs.day
    }

    // MARK: - Public methods

    public func date(calendar: Calendar) -> Date? {
        if day.isValid {
            return day.date(calendar: calendar)
        } else if month.isValid {
            return month.date(calendar: calendar)
        } else if year.isValid {
            return year.date(calendar: calendar)
        } else {
            return nil
        }
    }

    public func updatedValidComponents(with date: CXDate) -> CXDate {
        var newDate = CXDate()
        newDate.year = year.isValid ? date.year : year
        newDate.month = month.isValid ? date.month : month
        newDate.day = day.isValid ? date.day : day
        return newDate
    }

    // MARK: - Private methods

    /// Creates a default date formatter with "yyyy-MM-dd" format.
    private static func defaultFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}

// MARK: - Extensions

public extension CXDate {
    /// A constant representing the current date.
    static var now: CXDate {
        CXDate(.now)
    }

    static var new: CXDate {
        CXDate()
    }
}
