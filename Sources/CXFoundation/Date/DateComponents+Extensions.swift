//
//  File.swift
//  CXFoundation
//
//  Created by Cunqi Xiao on 7/13/25.
//

import Foundation

extension DateComponents {
    public static var day: DateComponents {
        DateComponents(hour: 0, minute: 0, second: 0)
    }

    public static var firstDayOfMonth: DateComponents {
        DateComponents(day: 1, hour: 0, minute: 0, second: 0)
    }

    public static var firstDayOfYear: DateComponents {
        DateComponents(month: 1, day: 1, hour: 0, minute: 0, second: 0)
    }
}

extension Calendar {
    public var firstWeekDay: DateComponents {
        DateComponents(hour: 0, minute: 0, second: 0, weekday: firstWeekday)
    }
}
