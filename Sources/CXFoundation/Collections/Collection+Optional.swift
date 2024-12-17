//
//  Collection+Optional.swift
//  CXFoundation
//
//  Created by Cunqi Xiao on 12/16/24.
//

import Foundation

/// A collection extension that adds safe access to elements using a subscript.
///
/// This extension provides a way to safely access elements of a collection without risking an out-of-bounds error.
/// If the index is out of bounds, it returns `nil` instead of causing a runtime error.
public extension Collection {
    /// Safely accesses the element at the specified index.
    ///
    /// - Parameter index: The index of the element to access.
    /// - Returns: The element at the specified index, or `nil` if the index is out of bounds.
    subscript(safe index: Index) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}
