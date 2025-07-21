//
//  Range+.swift
//  CXFoundation
//
//  Created by Cunqi Xiao on 12/18/24.
//

import Foundation

extension Swift.ClosedRange where Bound: Comparable {
    public func clamped(with item: Bound) -> Bound {
        min(max(lowerBound, item), upperBound)
    }
}
