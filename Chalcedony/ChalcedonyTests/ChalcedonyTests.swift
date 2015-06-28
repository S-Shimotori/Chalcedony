//
//  ChalcedonyTests.swift
//  ChalcedonyTests
//
//  Created by S-Shimotori on 6/19/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit
import XCTest

class ChalcedonyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }

    func testCCDDataModel() {
        let stayLaboDataList = [
            //日
            CCDStayLaboData(
                laboinDate: makeNSDate(2015, month: 6, day: 21, hour: 0, minute: 0, second: 0),
                laboridaDate: makeNSDate(2015, month: 6, day: 21, hour: 0, minute: 0, second: 10)),
            //月
            CCDStayLaboData(
                laboinDate: makeNSDate(2015, month: 6, day: 22, hour: 0, minute: 0, second: 0),
                laboridaDate: makeNSDate(2015, month: 6, day: 22, hour: 0, minute: 10, second: 0)),
            //火
            CCDStayLaboData(
                laboinDate: makeNSDate(2015, month: 6, day: 23, hour: 0, minute: 0, second: 0),
                laboridaDate: makeNSDate(2015, month: 6, day: 23, hour: 10, minute: 0, second: 0)),
            //水
            CCDStayLaboData(
                laboinDate: makeNSDate(2015, month: 6, day: 24, hour: 0, minute: 0, second: 0),
                laboridaDate: makeNSDate(2015, month: 6, day: 24, hour: 0, minute: 10, second: 10)),
            //木
            CCDStayLaboData(
                laboinDate: makeNSDate(2015, month: 6, day: 25, hour: 0, minute: 0, second: 0),
                laboridaDate: makeNSDate(2015, month: 6, day: 25, hour: 10, minute: 0, second: 10)),
            //金
            CCDStayLaboData(
                laboinDate: makeNSDate(2015, month: 6, day: 26, hour: 0, minute: 0, second: 0),
                laboridaDate: makeNSDate(2015, month: 6, day: 26, hour: 10, minute: 10, second: 0)),
            //土
            CCDStayLaboData(
                laboinDate: makeNSDate(2015, month: 6, day: 27, hour: 0, minute: 0, second: 0),
                laboridaDate: makeNSDate(2015, month: 6, day: 27, hour: 10, minute: 10, second: 10)),
        ]
        let dataModel = CCDDataModel(stayLaboDataList: stayLaboDataList)
        let calculatedData = dataModel.calculateStayLaboData()
        XCTAssertEqualWithAccuracy(calculatedData.totalByMonth[6 - 1], 40 * 3600 + 40 * 60 + 40, 1, "PASS")
        XCTAssertEqualWithAccuracy(calculatedData.totalByWeekday[0],    0        +  0      + 10, 1, "PASS")
        XCTAssertEqualWithAccuracy(calculatedData.totalByWeekday[1],    0        + 10 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(calculatedData.totalByWeekday[2],   10 * 3600 +  0      +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(calculatedData.totalByWeekday[3],    0        + 10 * 60 + 10, 1, "PASS")
        XCTAssertEqualWithAccuracy(calculatedData.totalByWeekday[4],   10 * 3600 +  0      + 10, 1, "PASS")
        XCTAssertEqualWithAccuracy(calculatedData.totalByWeekday[5],   10 * 3600 + 10 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(calculatedData.totalByWeekday[6],   10 * 3600 + 10 * 60 + 10, 1, "PASS")

        println(calculatedData.totalByMonth)
        println(calculatedData.totalByWeekday)
    }

    private func makeNSDate(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        return calendar.dateFromComponents(components)!
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
