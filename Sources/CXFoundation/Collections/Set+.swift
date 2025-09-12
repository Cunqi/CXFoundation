//
//  Set+.swift
//  CXFoundation
//
//  Created by Cunqi Xiao on 9/10/25.
//

import Foundation

extension Set {
    // MARK: - Computed Properties

    @inlinable
    public var isNotEmpty: Bool {
        !isEmpty
    }

    // MARK: - Functions

    public func toArray() -> [Element] {
        Array(self)
    }
}
