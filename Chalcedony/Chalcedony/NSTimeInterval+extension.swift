//
//  NSTimeInterval+extension.swift
//  Chalcedony
//
//  Created by S-Shimotori on 7/3/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import Foundation

extension NSTimeInterval {
    func convertToShow() -> (day: Int, hour: Int, minute: Int, second: Double) {
        var dwell = self
        let day = Int(dwell / (60 * 60 * 24))
        dwell %= 60 * 60 * 24
        let hour = Int(dwell / (60 * 60))
        dwell %= 60 * 60
        let minute = Int(dwell / 60)
        dwell %= 60
        let second = dwell
        return (day: day, hour: hour, minute: minute, second: second)
    }
}