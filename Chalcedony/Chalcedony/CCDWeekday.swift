//
//  CCDWeekday.swift
//  Chalcedony
//
//  Created by S-Shimotori on 6/30/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import Foundation

enum CCDWeekday: Int {
    case Sunday = 1
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday

    func toString() -> String {
        let name: String
        switch self {
        case .Sunday:
            name = "日"
        case .Monday:
            name = "月"
        case .Tuesday:
            name = "火"
        case .Wednesday:
            name = "水"
        case .Thursday:
            name = "木"
        case .Friday:
            name = "金"
        case .Saturday:
            name = "土"
        }
        return "\(name)曜日"
    }
}