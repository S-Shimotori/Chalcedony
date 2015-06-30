//
//  NSDate+extension.swift
//  Chalcedony
//
//  Created by S-Shimotori on 6/28/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit

extension NSDate {
    func date() -> (year: Int, month: Int, day: Int, weekday: Int) {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitWeekday, fromDate: self)
        return (components.year, components.month, components.day, components.weekday)
    }
    func time() -> (hour: Int, minute: Int, second: Int) {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond, fromDate: self)
        return (components.hour , components.minute, components.second)
    }
    func isEqualWithoutTime(otherNSDate: NSDate) -> Bool {
        let selfDate = self.date()
        let otherDate = otherNSDate.date()

        return selfDate.year == otherDate.year
            && selfDate.month == otherDate.month
            && selfDate.day == otherDate.day
    }
    func isDescendingWithoutTime(otherNSDate: NSDate) -> Bool {
        let selfDate = self.date()
        let otherDate = otherNSDate.date()

        if selfDate.year > otherDate.year {
            return true
        } else if selfDate.year < otherDate.year {
            return false
        }
        if selfDate.month > otherDate.month {
            return true
        } else if selfDate.month < otherDate.month {
            return false
        }
        if selfDate.day > otherDate.day {
            return true
        }
        return false
    }
    func isAscendingWithoutTime(otherNSDate: NSDate) -> Bool {
        let selfDate = self.date()
        let otherDate = otherNSDate.date()

        if selfDate.year < otherDate.year {
            return true
        } else if selfDate.year > otherDate.year {
            return false
        }
        if selfDate.month < otherDate.month {
            return true
        } else if selfDate.month > otherDate.month {
            return false
        }
        if selfDate.day < otherDate.day {
            return true
        }
        return false
    }
}
