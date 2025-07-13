//
//  File.swift
//  CXFoundation
//
//  Created by Cunqi Xiao on 7/13/25.
//

import Foundation

public extension DateComponents {
    static var day: DateComponents {
        DateComponents(hour: 0, minute: 0, second: 0)
    }

    static var firstDayOfMonth: DateComponents {
        DateComponents(day: 1, hour: 0, minute: 0, second: 0)
    }

    static var firstDayOfYear: DateComponents {
        DateComponents(month: 1, day: 1, hour: 0, minute: 0, second: 0)
    }
}

public extension Calendar {
    var firstWeekDay: DateComponents {
        DateComponents(hour: 0, minute: 0, second: 0, weekday: firstWeekday)
    }
}
