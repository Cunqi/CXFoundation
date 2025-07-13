//
//  File.swift
//  CXFoundation
//
//  Created by Cunqi Xiao on 7/13/25.
//

import Foundation

/// A struct representing a date with a unique identifier. by integrating the `Identifiable` protocol, it allows for easy identification, this will be useful in SwiftUI or other contexts where unique identification of objects is required.
public struct IdentifiableDate: Identifiable {

    // MARK: - Properties

    /// The underlying date value.
    public let value: Date

    /// A unique identifier for the date.
    public var id: Int {
        uniqueID
    }

    /// A unique identifier for the date, used to differentiate instances.
    private let uniqueID: Int

    // MARK: - Initializers
    
    /// Creates an `IdentifiableDate` with the specified date and a unique identifier.
    /// - Parameters:
    ///   - value: The date value to be wrapped.
    ///   - id: A unique identifier for the date instance.
    public init(value: Date, id: Int) {
        self.value = value
        self.uniqueID = id
    }
}

// MARK: - Date Extensions

public extension Date {

    /// Returns an `IdentifiableDate` with the current date and a unique identifier.
    var identified: IdentifiableDate {
        IdentifiableDate(value: self, id: hashValue)
    }
}
