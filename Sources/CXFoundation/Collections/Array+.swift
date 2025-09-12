//
//  Array+.swift
//  CXFoundation
//
//  Created by Cunqi Xiao on 9/10/25.
//

import Foundation

extension Array {
    @inlinable
    public var isNotEmpty: Bool {
        !isEmpty
    }
}

extension Array where Element: Hashable {
    public func toSet() -> Set<Element> {
        Set(self)
    }
}
