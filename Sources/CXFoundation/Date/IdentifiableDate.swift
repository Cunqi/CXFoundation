//
//  File.swift
//  CXFoundation
//
//  Created by Cunqi Xiao on 7/13/25.
//

import Foundation

// MARK: - IdentifiableDate

/// A struct representing a date with a unique identifier. by integrating the `Identifiable` protocol, it allows for easy identification, this will be useful in SwiftUI or other contexts where unique identification of objects is required.
public struct IdentifiableDate: Identifiable {
    // MARK: - Properties

    // MARK: Public

    /// The underlying date value.
    public let value: Date

    /// A unique identifier for the date.
    public let id: String

    // MARK: - Lifecycle

    // MARK: - Initializers

    /// Creates an `IdentifiableDate` with the specified date and a unique identifier.
    /// - Parameters:
    ///   - value: The date value to be wrapped.
    ///   - id: A unique identifier for the date instance.
    public init(value: Date, id: String) {
        self.value = value
        self.id = id
    }
}

// MARK: - Date Extensions

extension Date {
    /// Returns an `IdentifiableDate` with the current date and a unique identifier.
    public func identified(id: String) -> IdentifiableDate {
        IdentifiableDate(value: self, id: id)
    }
}
