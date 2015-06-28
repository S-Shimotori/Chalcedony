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
            CCDStayLaboData(laboinDate: NSDate(), laboridaDate: NSDate(timeIntervalSinceNow: NSTimeInterval(60 * 60 * 4)
))
        ]
        let dataModel = CCDDataModel(stayLaboDataList: stayLaboDataList)
        let calculatedData = dataModel.calculateStayLaboData()

        println(calculatedData.numberByMonth)
        println(calculatedData.numberByWeekday)
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
        components.month = month
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
