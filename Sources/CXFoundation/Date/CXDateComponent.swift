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
public protocol CXDateComponent: Comparable, CustomStringConvertible, Equatable, Sendable {
    associatedtype Value

    /// The underlying value of the date component.
    var value: Value { get }

    /// Returns a Boolean value indicating whether the date component is valid.
    var isValid: Bool { get }
}

/// A struct representing a year component in a date.
public struct CXDateComponentYear: CXDateComponent {
    /// The numeric value of the year.
    public let value: Int

    /// Returns `true` if the year value is positive.
    public var isValid: Bool { value > 0 }

    /// A string representation of the year value.
    public var description: String { String(value) }

    /// Creates a year component with the specified value.
    /// - Parameter value: The numeric value of the year.
    public init(_ value: Int) {
        self.value = value
    }

    /// An empty year component with value 0.
    public static let empty = CXDateComponentYear(0)

    // MARK: - Comparable

    public static func < (lhs: CXDateComponentYear, rhs: CXDateComponentYear) -> Bool {
        lhs.value < rhs.value
    }
}

/// A struct representing a month component in a date.
public struct CXDateComponentMonth: CXDateComponent {
    // MARK: - Enums

    public enum MonthStyle {
        case short, long
    }

    /// The numeric value of the month (1-12).
    public let value: Int

    /// Returns `true` if the month value is between 1 and 12 inclusive.
    public var isValid: Bool { (1 ... 12).contains(value) }

    /// A string representation of the month value.
    public var description: String { monthSymbol }

    // MARK: - Private properties

    private let monthSymbol: String

    /// Creates a month component with the specified value.
    /// - Parameter value: The numeric value of the month (1-12).
    public init(_ value: Int, calendar: Calendar = .current, monthStyle: MonthStyle = .short) {
        self.value = value
        monthSymbol = CXDateComponentMonth.fetchMonthSymbol(value, calendar: calendar, monthStyle: monthStyle)
    }

    /// An empty month component with value 0.
    public static let empty = CXDateComponentMonth(0)

    // MARK: - Comparable

    public static func < (lhs: CXDateComponentMonth, rhs: CXDateComponentMonth) -> Bool {
        lhs.value < rhs.value
    }

    // MARK: - Private methods

    private static func fetchMonthSymbol(_ value: Int, calendar: Calendar = .current, monthStyle: MonthStyle = .short) -> String {
        let monthSymbols = monthStyle == .short ? calendar.shortMonthSymbols : calendar.monthSymbols
        return monthSymbols[safe: value - 1] ?? ""
    }
}

/// A struct representing a day component in a date.
public struct CXDateComponentDay: CXDateComponent {
    /// The numeric value of the day.
    public let value: Int

    /// Returns `true` if the day value is between 1 and 31 inclusive.
    /// Note: This is a basic validation and doesn't account for varying month lengths.
    public var isValid: Bool { (1 ... 31).contains(value) }

    /// A string representation of the day value.
    public var description: String { String(value) }

    /// Creates a day component with the specified value.
    /// - Parameter value: The numeric value of the day.
    public init(_ value: Int) {
        self.value = value
    }

    /// An empty day component with value 0.
    public static let empty = CXDateComponentDay(0)

    // MARK: - Comparable

    public static func < (lhs: CXDateComponentDay, rhs: CXDateComponentDay) -> Bool {
        lhs.value < rhs.value
    }
}

// MARK: - Extensions

public extension CXDateComponent where Self == CXDateComponentYear {
    static func year(_ value: Int) -> CXDateComponentYear {
        CXDateComponentYear(value)
    }
}

public extension CXDateComponent where Self == CXDateComponentMonth {
    static func month(_ value: Int, calendar _: Calendar = .current, formatter _: DateFormatter? = nil) -> CXDateComponentMonth {
        CXDateComponentMonth(value)
    }
}

public extension CXDateComponent where Self == CXDateComponentDay {
    static func day(_ value: Int) -> CXDateComponentDay {
        CXDateComponentDay(value)
    }
}

/// Creates a date component with the specified value.
