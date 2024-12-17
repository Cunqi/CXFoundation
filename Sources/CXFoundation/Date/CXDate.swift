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
    // MARK: - Public properties

    /// The year component of the date.
    public var year: CXDateComponentYear

    /// The month component of the date.
    public var month: CXDateComponentMonth

    /// The day component of the date.
    public var day: CXDateComponentDay

    /// The underlying Foundation Date value.
    public var value: Date

    /// Returns `true` if any of the components (year, month, day) are valid.
    public var isValid: Bool {
        year.isValid || month.isValid || day.isValid
    }

    /// A string representation of the date in "yyyy-MM-dd" format.
    public var description: String {
        formatter.string(from: value)
    }

    // MARK: - Private properties

    /// The date formatter used for string conversion.
    private let formatter: DateFormatter

    // MARK: - Initializers

    /// Creates a date from a Foundation Date object.
    /// - Parameters:
    ///   - date: The Foundation Date to create from.
    ///   - calendar: The calendar to use for date calculations (defaults to current).
    ///   - formatter: Optional custom date formatter (defaults to "yyyy-MM-dd" format).
    public init(_ date: Date, calendar: Calendar = .current, formatter: DateFormatter? = nil) {
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        year = components.year.map { .init($0) } ?? .empty
        month = components.month.map { .init($0) } ?? .empty
        day = components.day.map { .init($0) } ?? .empty
        value = calendar.date(from: DateComponents(year: year.value, month: month.value, day: day.value)) ?? .now
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

    // MARK: - Private methods

    /// Creates a default date formatter with "yyyy-MM-dd" format.
    private static func defaultFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}