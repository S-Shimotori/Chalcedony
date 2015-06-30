//
//  CCDMonth.swift
//  Chalcedony
//
//  Created by S-Shimotori on 6/30/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import Foundation

enum CCDMonth: Int {
    case January = 1
    case February
    case March
    case April
    case May
    case June
    case July
    case August
    case September
    case October
    case November
    case December

    func toString() -> String {
        return "\(self.rawValue)月"
    }
}