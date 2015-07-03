//
//  CCDStayLaboData.swift
//  Chalcedony
//
//  Created by S-Shimotori on 6/28/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import Foundation

struct CCDStayLaboData: Comparable {
    let laboinDate: NSDate
    let laboridaDate: NSDate
    init(laboinDate: NSDate, laboridaDate: NSDate) {
        self.laboinDate = laboinDate
        self.laboridaDate = laboridaDate
    }
}

func < (lhs: CCDStayLaboData, rhs: CCDStayLaboData) -> Bool {
    let comparisonResult: NSComparisonResult = lhs.laboinDate.compare(rhs.laboinDate)
    switch comparisonResult {
    case .OrderedSame:
        return lhs.laboridaDate.compare(rhs.laboridaDate) == .OrderedAscending
    default:
        return comparisonResult == .OrderedAscending
    }
}
func == (lhs: CCDStayLaboData, rhs: CCDStayLaboData) -> Bool {
    let laboinComparisonResult = lhs.laboinDate.compare(rhs.laboinDate)
    let laboridaComparisonResult = lhs.laboinDate.compare(rhs.laboridaDate)
    return laboinComparisonResult == .OrderedSame
        && laboridaComparisonResult == .OrderedSame
}