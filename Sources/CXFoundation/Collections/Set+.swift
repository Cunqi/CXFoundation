//
//  Set+.swift
//  CXFoundation
//
//  Created by Cunqi Xiao on 9/10/25.
//

import Foundation

extension Set {
    public var isNotEmpty: Bool {
        !isEmpty
    }

    public func toArray() -> [Element] {
        Array(self)
    }
}
