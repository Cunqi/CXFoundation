//
//  File.swift
//  CXFoundation
//
//  Created by Cunqi Xiao on 7/13/25.
//

import Foundation

public extension Calendar {
    func startOfMonth(for date: Date) -> Date {
        let components = dateComponents([.year, .month], from: date)
        return self.date(from: components)!
    }

    func startOfYear(for date: Date) -> Date {
        let components = dateComponents([.year], from: date)
        return self.date(from: components)!
    }

    func isSameMonthInYear(_ date1: Date, _ date2: Date) -> Bool {
        isDate(date1, equalTo: date2, toGranularities: [.month, .year])
    }

    func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        isDate(date1, equalTo: date2, toGranularities: [.month, .year, .day])
    }

    func isDate(_ date1: Date, equalTo date2: Date, toGranularities components: Set<Calendar.Component>) -> Bool {
        components.reduce(into: true) { isEqual, component in
            isEqual = isEqual && isDate(date1, equalTo: date2, toGranularity: component)
        }
    }
}

