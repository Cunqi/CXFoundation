//
//  CXDateComponent.swift
//  CXFoundation
//
//  Created by Cunqi Xiao on 12/16/24.
//

import Foundation

/// A protocol that represents a date component with validation and comparison capabilities.
///
/// This protocol defines common behavior for date-related components such as dates, years, months, and days.
/// Each component must provide validation and support standard Swift protocols for comparison,
/// string representation, and data handling.
public protocol CXDateComponent: Comparable, CustomStringConvertible, Equatable, Identifiable, Sendable {
    associatedtype Value

    /// The underlying value of the date component.
    var value: Value { get }

    /// Returns a Boolean value indicating whether the date component is valid.
    var isValid: Bool { get }

    func date(calendar: Calendar) -> Date?
}

/// A struct representing a year component in a date.
public struct CXDateComponentYear: CXDateComponent {
    /// The numeric value of the year.
    public let value: Int

    /// The unique identifier of the year component.
    public var id: String { value.description }

    /// Returns `true` if the year value is positive.
    public var isValid: Bool { value > 0 }

    /// A string representation of the year value.
    public var description: String { value.description }

    /// Creates a year component with the specified value.
    /// - Parameter value: The numeric value of the year.
    public init(_ value: Int) {
        self.value = value
    }

    public init(_ value: Date, calendar: Calendar = .current) {
        self.value = calendar.component(.year, from: value)
    }

    /// An empty year component with value 0.
    public static let empty = CXDateComponentYear(0)

    // MARK: - Comparable

    public static func < (lhs: CXDateComponentYear, rhs: CXDateComponentYear) -> Bool {
        lhs.value < rhs.value
    }

    // MARK: - Equatable

    public static func == (lhs: CXDateComponentYear, rhs: CXDateComponentYear) -> Bool {
        lhs.value == rhs.value
    }

    // MARK: - Public methods

    public func date(calendar: Calendar = .current) -> Date? {
        calendar.date(from: DateComponents(year: value))
    }
}

/// A struct representing a month component in a date.
public struct CXDateComponentMonth: CXDateComponent {

    // MARK: - Public properties

    public let year: CXDateComponentYear

    /// The numeric value of the month (1-12).
    public let value: Int

    /// The unique identifier of the year component.
    public var id: String { year.id + "-" + description }

    /// Returns `true` if the month value is between 1 and 12 inclusive.
    public var isValid: Bool { year.isValid && (1 ... 12).contains(value) }

    /// A string representation of the month value.
    public var description: String { value.description }

    public init(year: Int, month: Int) {
        self.value = month
        self.year = CXDateComponentYear(year)
    }

    public init(_ value: Date, calendar: Calendar = .current) {
        self.year = CXDateComponentYear(value, calendar: calendar)
        self.value = calendar.component(.month, from: value)
    }

    /// An empty month component with value 0.
    public static let empty = CXDateComponentMonth(year: 0, month: 0)

    // MARK: - Comparable

    public static func < (lhs: CXDateComponentMonth, rhs: CXDateComponentMonth) -> Bool {
        if lhs.year != rhs.year {
            return lhs.year < rhs.year
        }
        return lhs.value < rhs.value
    }

    // MARK: - Equatable

    public static func == (lhs: CXDateComponentMonth, rhs: CXDateComponentMonth) -> Bool {
        lhs.value == rhs.value && lhs.year == rhs.year
    }

    // MARK: - Public methods

    public func date(calendar: Calendar = .current) -> Date? {
        calendar.date(from: DateComponents(year: year.value, month: value))
    }
}

/// A struct representing a day component in a date.
public struct CXDateComponentDay: CXDateComponent {
    public let month: CXDateComponentMonth

    /// The numeric value of the day.
    public let value: Int

    /// The unique identifier of the year component.
    public var id: String { month.id + "-" + description }

    /// Returns `true` if the day value is between 1 and 31 inclusive.
    /// Note: This is a basic validation and doesn't account for varying month lengths.
    public var isValid: Bool { month.isValid && (1 ... 31).contains(value) }

    /// A string representation of the day value.
    public var description: String { value.description }

    public init(month: CXDateComponentMonth, day: Int) {
        self.month = month
        value = day
    }

    public init(_ value: Date, calendar: Calendar = .current) {
        month = CXDateComponentMonth(value, calendar: calendar)
        self.value = calendar.component(.day, from: value)
    }

    /// An empty day component with value 0.
    public static let empty = CXDateComponentDay(month: .empty, day: 0)

    // MARK: - Comparable

    public static func < (lhs: CXDateComponentDay, rhs: CXDateComponentDay) -> Bool {
        if lhs.month != rhs.month {
            return lhs.month < rhs.month
        }
        return lhs.value < rhs.value
    }

    // MARK: - Equatable

    public static func == (lhs: CXDateComponentDay, rhs: CXDateComponentDay) -> Bool {
        lhs.value == rhs.value && lhs.month == rhs.month
    }

    // MARK: - Public methods

    public func date(calendar: Calendar = .current) -> Date? {
        calendar.date(from: DateComponents(year: month.year.value, month: month.value, day: value))
    }
}
