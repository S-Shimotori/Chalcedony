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

    func testCCDStayLaboDataProcessor() {
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
        XCTAssertEqualWithAccuracy(processedData.totalByMonth[CCDMonth.June.hashValue],           40 * 3600 + 40 * 60 + 40, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Sunday.hashValue],      0 * 3600 +  0 * 60 + 10, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Monday.hashValue],      0 * 3600 + 10 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Tuesday.hashValue],    10 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Wednesday.hashValue],   0 * 3600 + 10 * 60 + 10, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Thursday.hashValue],   10 * 3600 +  0 * 60 + 10, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Friday.hashValue],     10 * 3600 + 10 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Saturday.hashValue],   10 * 3600 + 10 * 60 + 10, 1, "PASS")
        XCTAssertEqual(processedData.numberByMonth,   [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0], "PASS")
        XCTAssertEqual(processedData.numberByWeekday, [1, 1, 1, 1, 1, 1, 1]               , "PASS")
    }

    func testCCDStayLaboDataProcessorWithExtendDate() {
        let stayLaboDataList = [
            //Sunday -> Monday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 21, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 22, hour:  0, minute:  0, second: 10)),
            //Tuesday -> Wednesday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 23, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 24, hour:  0, minute: 10, second:  0)),
            //Thursday -> Friday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 25, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 26, hour: 10, minute:  0, second: 10)),
            //Saturday -> Sunday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 27, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 28, hour: 10, minute: 10, second: 10)),
        ]
        let dataProcessor = CCDStayLaboDataProcessor(stayLaboDataList: stayLaboDataList)
        let processedData = dataProcessor.processStayLaboData()
        XCTAssertEqualWithAccuracy(processedData.totalByMonth[CCDMonth.June.hashValue],          116 * 3600 + 20 * 60 + 30, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Sunday.hashValue],     34 * 3600 + 10 * 60 + 10, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Monday.hashValue],      0 * 3600 +  0 * 60 + 10, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Tuesday.hashValue],    24 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Wednesday.hashValue],   0 * 3600 + 10 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Thursday.hashValue],   24 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Friday.hashValue],     10 * 3600 +  0 * 60 + 10, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Saturday.hashValue],   24 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqual(processedData.numberByMonth,   [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0], "PASS")
        XCTAssertEqual(processedData.numberByWeekday, [2, 1, 1, 1, 1, 1, 1]               , "PASS")
    }

    func testCCDStayLaboDataProcessorWithReverse() {
        let stayLaboDataList = [
            //Saturday -> Sunday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 27, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 28, hour: 10, minute: 10, second: 10)),
            //Thursday -> Friday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 25, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 26, hour: 10, minute:  0, second: 10)),
            //Tuesday -> Wednesday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 23, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 24, hour:  0, minute: 10, second:  0)),
            //Sunday -> Monday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 21, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 22, hour:  0, minute:  0, second: 10)),

        ]
        let dataProcessor = CCDStayLaboDataProcessor(stayLaboDataList: stayLaboDataList)
        let processedData = dataProcessor.processStayLaboData()
        XCTAssertEqualWithAccuracy(processedData.totalByMonth[CCDMonth.June.hashValue],          116 * 3600 + 20 * 60 + 30, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Sunday.hashValue],     34 * 3600 + 10 * 60 + 10, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Monday.hashValue],      0 * 3600 +  0 * 60 + 10, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Tuesday.hashValue],    24 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Wednesday.hashValue],   0 * 3600 + 10 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Thursday.hashValue],   24 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Friday.hashValue],     10 * 3600 +  0 * 60 + 10, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Saturday.hashValue],   24 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqual(processedData.numberByMonth,   [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0], "PASS")
        XCTAssertEqual(processedData.numberByWeekday, [2, 1, 1, 1, 1, 1, 1]               , "PASS")
    }

    func testCCDStayLaboDataProcessorWithDuplicate() {
        let stayLaboDataList = [
            //Sunday -> Monday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 21, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 22, hour:  0, minute:  0, second: 10)),
            //Monday -> Tuesday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 22, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 23, hour:  0, minute: 10, second:  0)),
            //Tuesday -> Wednesday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 23, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 24, hour: 10, minute:  0, second:  0)),
            //Wednesday -> Thursday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 24, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 25, hour:  0, minute: 10, second: 10)),
            //Thursday -> Friday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 25, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 26, hour: 10, minute:  0, second: 10)),
            //Friday -> Saturday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 26, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 27, hour: 10, minute: 10, second:  0)),
            //Saturday -> Sunday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 27, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 28, hour: 10, minute: 10, second: 10)),
        ]
        let dataProcessor = CCDStayLaboDataProcessor(stayLaboDataList: stayLaboDataList)
        let processedData = dataProcessor.processStayLaboData()
        XCTAssertEqualWithAccuracy(processedData.totalByMonth[CCDMonth.June.hashValue],         178 * 3600 + 10 * 60 + 10, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Sunday.hashValue],    34 * 3600 + 10 * 60 + 10, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Monday.hashValue],    24 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Tuesday.hashValue],   24 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Wednesday.hashValue], 24 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Thursday.hashValue],  24 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Friday.hashValue],    24 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Saturday.hashValue],  24 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqual(processedData.numberByMonth,   [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0], "PASS")
        XCTAssertEqual(processedData.numberByWeekday, [2, 1, 1, 1, 1, 1, 1]               , "PASS")
    }

    func testCCDStayLaboDataProcessorWithRedundantData() {
        let stayLaboDataList = [
            //Sunday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 21, hour:  9, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 21, hour: 17, minute:  0, second:  0)),
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 21, hour: 10, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 21, hour: 12, minute:  0, second:  0)),
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 21, hour: 11, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 21, hour: 13, minute:  0, second:  0)),
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 21, hour: 14, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 21, hour: 16, minute:  0, second:  0)),
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 21, hour: 16, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 21, hour: 17, minute:  0, second:  0)),
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 21, hour: 17, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 21, hour: 18, minute:  0, second:  0)),
        ]
        let dataProcessor = CCDStayLaboDataProcessor(stayLaboDataList: stayLaboDataList)
        let processedData = dataProcessor.processStayLaboData()
        XCTAssertEqualWithAccuracy(processedData.totalByMonth[CCDMonth.June.hashValue],            9 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Sunday.hashValue],      9 * 3600 +  0      +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Monday.hashValue],      0 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Tuesday.hashValue],     0 * 3600 +  0      +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Wednesday.hashValue],   0 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Thursday.hashValue],    0 * 3600 +  0      +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Friday.hashValue],      0 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Saturday.hashValue],    0 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqual(processedData.numberByMonth,   [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0], "PASS")
        XCTAssertEqual(processedData.numberByWeekday, [1, 0, 0, 0, 0, 0, 0]               , "PASS")
    }

    func testCCDStayLaboDataProcessorWithSameDate() {
        let stayLaboDataList = [
            //Sunday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 21, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 21, hour:  0, minute:  0, second: 10)),
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 21, hour:  1, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 21, hour:  1, minute:  0, second: 10)),
            //Monday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 22, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 22, hour:  0, minute: 10, second:  0)),
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 22, hour:  1, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 22, hour:  1, minute: 10, second:  0)),
            //Wednesday
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 24, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 24, hour:  0, minute: 10, second: 10)),
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 24, hour:  1, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 24, hour:  1, minute: 10, second: 10)),
        ]
        let dataProcessor = CCDStayLaboDataProcessor(stayLaboDataList: stayLaboDataList)
        let processedData = dataProcessor.processStayLaboData()
        XCTAssertEqualWithAccuracy(processedData.totalByMonth[CCDMonth.June.hashValue],            0 * 3600 + 40 * 60 + 40, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Sunday.hashValue],      0 * 3600 +  0 * 60 + 20, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Monday.hashValue],      0 * 3600 + 20 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Tuesday.hashValue],     0 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Wednesday.hashValue],   0 * 3600 + 20 * 60 + 20, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Thursday.hashValue],    0 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Friday.hashValue],      0 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Saturday.hashValue],    0 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqual(processedData.numberByMonth,   [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0], "PASS")
        XCTAssertEqual(processedData.numberByWeekday, [1, 1, 1, 1, 0, 0, 0]               , "PASS")
    }

    func testCCDStayLaboDataProcessorWithExtendMonth() {
        let stayLaboDataList = [
            //Tuesday(June)
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 30, hour:  0, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.June     , day: 30, hour:  0, minute:  0, second: 10)),
            //Tuesday(June) -> Wednesday(July)
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 30, hour:  20, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.July     , day:  1, hour:   5, minute:  0, second:  0)),
            //Tuesday(June) -> Wednesday(July)
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 30, hour:  22, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.July     , day:  1, hour:   4, minute:  0, second:  0)),
            //Tuesday(June) -> Wednesday(July)
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.June     , day: 30, hour:  23, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.July     , day:  1, hour:   6, minute:  0, second:  0)),
            //Wednesday(July)
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.July     , day:  1, hour:   9, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.July     , day:  1, hour:  17, minute:  0, second:  0)),
            //Wednesday(July)
            CCDStayLaboData(
                laboinDate:   makeNSDate(2015, month: CCDMonth.July     , day:  1, hour:  18, minute:  0, second:  0),
                laboridaDate: makeNSDate(2015, month: CCDMonth.July     , day:  1, hour:  19, minute:  0, second:  0)),
        ]
        let dataProcessor = CCDStayLaboDataProcessor(stayLaboDataList: stayLaboDataList)
        let processedData = dataProcessor.processStayLaboData()
        XCTAssertEqualWithAccuracy(processedData.totalByMonth[CCDMonth.June.hashValue],            4 * 3600 +  0 * 60 + 10, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByMonth[CCDMonth.July.hashValue],           15 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Sunday.hashValue],      0 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Monday.hashValue],      0 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Tuesday.hashValue],     4 * 3600 +  0 * 60 + 10, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Wednesday.hashValue],  15 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Thursday.hashValue],    0 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Friday.hashValue],      0 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqualWithAccuracy(processedData.totalByWeekday[CCDWeekday.Saturday.hashValue],    0 * 3600 +  0 * 60 +  0, 1, "PASS")
        XCTAssertEqual(processedData.numberByMonth,   [0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0], "PASS")
        XCTAssertEqual(processedData.numberByWeekday, [0, 0, 1, 1, 0, 0, 0]               , "PASS")
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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
