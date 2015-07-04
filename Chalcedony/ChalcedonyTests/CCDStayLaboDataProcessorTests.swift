//
//  CCDStayLaboDataProcessorTestCase.swift
//  Chalcedony
//
//  Created by S-Shimotori on 7/4/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit
import XCTest
import Nimble

class CCDStayLaboDataProcessorTests: XCTestCase {
    func testProcess() {
        let stayLaboDataList = [
            //Sunday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 21, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 21, hour:  0, minute:  0, second: 10)),
            //Monday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 22, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 22, hour:  0, minute: 10, second:  0)),
            //Tuesday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 23, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 23, hour: 10, minute:  0, second:  0)),
            //Wednesday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 24, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 24, hour:  0, minute: 10, second: 10)),
            //Thursday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 25, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 25, hour: 10, minute:  0, second: 10)),
            //Friday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 26, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 26, hour: 10, minute: 10, second:  0)),
            //Saturday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 27, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 27, hour: 10, minute: 10, second: 10)),
        ]
        let dataProcessor = CCDStayLaboDataProcessor(stayLaboDataList: stayLaboDataList)
        let processedData = dataProcessor.processStayLaboData()

        expect(processedData.totalByMonth[CCDMonth.June.hashValue]).to(equal(          40 * 3600 + 40 * 60 + 40))
        expect(processedData.totalByWeekday[CCDWeekday.Sunday.hashValue]).to(equal(     0 * 3600 +  0 * 60 + 10))
        expect(processedData.totalByWeekday[CCDWeekday.Monday.hashValue]).to(equal(     0 * 3600 + 10 * 60 +  0))
        expect(processedData.totalByWeekday[CCDWeekday.Tuesday.hashValue]).to(equal(   10 * 3600 +  0 * 60 +  0))
        expect(processedData.totalByWeekday[CCDWeekday.Wednesday.hashValue]).to(equal(  0 * 3600 + 10 * 60 + 10))
        expect(processedData.totalByWeekday[CCDWeekday.Thursday.hashValue]).to(equal(  10 * 3600 +  0 * 60 + 10))
        expect(processedData.totalByWeekday[CCDWeekday.Friday.hashValue]).to(equal(    10 * 3600 + 10 * 60 +  0))
        expect(processedData.totalByWeekday[CCDWeekday.Saturday.hashValue]).to(equal(  10 * 3600 + 10 * 60 + 10))
        expect(processedData.numberByMonth).to(equal([0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0]))
        expect(processedData.numberByWeekday).to(equal([1, 1, 1, 1, 1, 1, 1]))
    }

    private func makeNSDate(year: Int, month: CCDMonth, day: Int, hour: Int, minute: Int, second: Int) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.year = year
        components.month = month.rawValue
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        return calendar.dateFromComponents(components)!
    }
}
