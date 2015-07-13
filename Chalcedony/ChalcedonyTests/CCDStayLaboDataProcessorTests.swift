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
import Quick

class CCDStayLaboDataProcessorTests: QuickSpec {
    private enum IT: String {
        case ProceededValue = "has processed correctly data"
        case NumberOfDay = "has the correct number of data"
    }
    override func spec() {
        describe("data when you laboin and laborida") {
            var processedData: CCDCalculatedData!
            context("when you get one data per day") {
                beforeEach {
                    let stayLaboDataList = [
                        //Sunday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 21, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 21, hour:  0, minute:  0, second: 10)),
                        //Monday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 22, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 22, hour:  0, minute: 10, second:  0)),
                        //Tuesday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 23, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 23, hour: 10, minute:  0, second:  0)),
                        //Wednesday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 24, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 24, hour:  0, minute: 10, second: 10)),
                        //Thursday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 25, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 25, hour: 10, minute:  0, second: 10)),
                        //Friday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 26, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 26, hour: 10, minute: 10, second:  0)),
                        //Saturday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 27, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 27, hour: 10, minute: 10, second: 10)),
                    ]
                    let dataProcessor = CCDStayLaboDataProcessor(stayLaboDataList: stayLaboDataList)
                    processedData = dataProcessor.processStayLaboData()
                }

                it(IT.ProceededValue.rawValue) {
                    expect(processedData.totalByMonth[CCDMonth.June.hashValue]).to(equal(          40 * 3600 + 40 * 60 + 40))
                    expect(processedData.totalByWeekday[CCDWeekday.Sunday.hashValue]).to(equal(     0 * 3600 +  0 * 60 + 10))
                    expect(processedData.totalByWeekday[CCDWeekday.Monday.hashValue]).to(equal(     0 * 3600 + 10 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Tuesday.hashValue]).to(equal(   10 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Wednesday.hashValue]).to(equal(  0 * 3600 + 10 * 60 + 10))
                    expect(processedData.totalByWeekday[CCDWeekday.Thursday.hashValue]).to(equal(  10 * 3600 +  0 * 60 + 10))
                    expect(processedData.totalByWeekday[CCDWeekday.Friday.hashValue]).to(equal(    10 * 3600 + 10 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Saturday.hashValue]).to(equal(  10 * 3600 + 10 * 60 + 10))
                }
                it(IT.NumberOfDay.rawValue) {
                    expect(processedData.numberByMonth).to(equal([0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0]))
                    expect(processedData.numberByWeekday).to(equal([1, 1, 1, 1, 1, 1, 1]))
                }
            }

            context("when data extends the following day") {
                beforeEach {
                    let stayLaboDataList = [
                        //Sunday -> Monday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 21, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 22, hour:  0, minute:  0, second: 10)),
                        //Tuesday -> Wednesday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 23, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 24, hour:  0, minute: 10, second:  0)),
                        //Thursday -> Friday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 25, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 26, hour: 10, minute:  0, second: 10)),
                        //Saturday -> Sunday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 27, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 28, hour: 10, minute: 10, second: 10)),
                    ]
                    let dataProcessor = CCDStayLaboDataProcessor(stayLaboDataList: stayLaboDataList)
                    processedData = dataProcessor.processStayLaboData()
                }
                it(IT.ProceededValue.rawValue) {
                    expect(processedData.totalByMonth[CCDMonth.June.hashValue]).to(equal(         116 * 3600 + 20 * 60 + 30))
                    expect(processedData.totalByWeekday[CCDWeekday.Sunday.hashValue]).to(equal(    34 * 3600 + 10 * 60 + 10))
                    expect(processedData.totalByWeekday[CCDWeekday.Monday.hashValue]).to(equal(     0 * 3600 +  0 * 60 + 10))
                    expect(processedData.totalByWeekday[CCDWeekday.Tuesday.hashValue]).to(equal(   24 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Wednesday.hashValue]).to(equal(  0 * 3600 + 10 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Thursday.hashValue]).to(equal(  24 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Friday.hashValue]).to(equal(    10 * 3600 +  0 * 60 + 10))
                    expect(processedData.totalByWeekday[CCDWeekday.Saturday.hashValue]).to(equal(  24 * 3600 +  0 * 60 +  0))
                }
                it(IT.NumberOfDay.rawValue) {
                    expect(processedData.numberByMonth).to(equal([0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0]))
                    expect(processedData.numberByWeekday).to(equal([2, 1, 1, 1, 1, 1, 1]))
                }
            }

            context("when data's order is reversed") {
                beforeEach {
                    let stayLaboDataList = [
                        //Saturday -> Sunday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 27, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 28, hour: 10, minute: 10, second: 10)),
                        //Thursday -> Friday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 25, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 26, hour: 10, minute:  0, second: 10)),
                        //Tuesday -> Wednesday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 23, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 24, hour:  0, minute: 10, second:  0)),
                        //Sunday -> Monday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 21, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 22, hour:  0, minute:  0, second: 10)),
                        
                    ]
                    let dataProcessor = CCDStayLaboDataProcessor(stayLaboDataList: stayLaboDataList)
                    processedData = dataProcessor.processStayLaboData()
                }
                it(IT.ProceededValue.rawValue) {
                    expect(processedData.totalByMonth[CCDMonth.June.hashValue]).to(equal(         116 * 3600 + 20 * 60 + 30))
                    expect(processedData.totalByWeekday[CCDWeekday.Sunday.hashValue]).to(equal(    34 * 3600 + 10 * 60 + 10))
                    expect(processedData.totalByWeekday[CCDWeekday.Monday.hashValue]).to(equal(     0 * 3600 +  0 * 60 + 10))
                    expect(processedData.totalByWeekday[CCDWeekday.Tuesday.hashValue]).to(equal(   24 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Wednesday.hashValue]).to(equal(  0 * 3600 + 10 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Thursday.hashValue]).to(equal(  24 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Friday.hashValue]).to(equal(    10 * 3600 +  0 * 60 + 10))
                    expect(processedData.totalByWeekday[CCDWeekday.Saturday.hashValue]).to(equal(  24 * 3600 +  0 * 60 +  0))
                }
                it(IT.NumberOfDay.rawValue) {
                    expect(processedData.numberByMonth).to(equal([0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0]))
                    expect(processedData.numberByWeekday).to(equal([2, 1, 1, 1, 1, 1, 1]))
                }
            }

            context("when data are duplicate") {
                beforeEach {
                    let stayLaboDataList = [
                        //Sunday -> Monday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 21, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 22, hour:  0, minute:  0, second: 10)),
                        //Monday -> Tuesday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 22, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 23, hour:  0, minute: 10, second:  0)),
                        //Tuesday -> Wednesday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 23, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 24, hour: 10, minute:  0, second:  0)),
                        //Wednesday -> Thursday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 24, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 25, hour:  0, minute: 10, second: 10)),
                        //Thursday -> Friday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 25, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 26, hour: 10, minute:  0, second: 10)),
                        //Friday -> Saturday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 26, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 27, hour: 10, minute: 10, second:  0)),
                        //Saturday -> Sunday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 27, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 28, hour: 10, minute: 10, second: 10)),
                    ]
                    let dataProcessor = CCDStayLaboDataProcessor(stayLaboDataList: stayLaboDataList)
                    processedData = dataProcessor.processStayLaboData()
                }
                it(IT.ProceededValue.rawValue) {
                    expect(processedData.totalByMonth[CCDMonth.June.hashValue]).to(equal(         178 * 3600 + 10 * 60 + 10))
                    expect(processedData.totalByWeekday[CCDWeekday.Sunday.hashValue]).to(equal(    34 * 3600 + 10 * 60 + 10))
                    expect(processedData.totalByWeekday[CCDWeekday.Monday.hashValue]).to(equal(    24 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Tuesday.hashValue]).to(equal(   24 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Wednesday.hashValue]).to(equal( 24 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Thursday.hashValue]).to(equal(  24 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Friday.hashValue]).to(equal(    24 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Saturday.hashValue]).to(equal(  24 * 3600 +  0 * 60 +  0))
                }
                it(IT.NumberOfDay.rawValue) {
                    expect(processedData.numberByMonth).to(equal([0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0]))
                    expect(processedData.numberByWeekday).to(equal([2, 1, 1, 1, 1, 1, 1]))
                }
            }

            context("when data are redundant") {
                beforeEach {
                    let stayLaboDataList = [
                        //Sunday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 21, hour:  9, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 21, hour: 17, minute:  0, second:  0)),
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 21, hour: 10, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 21, hour: 12, minute:  0, second:  0)),
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 21, hour: 11, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 21, hour: 13, minute:  0, second:  0)),
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 21, hour: 14, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 21, hour: 16, minute:  0, second:  0)),
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 21, hour: 16, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 21, hour: 17, minute:  0, second:  0)),
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 21, hour: 17, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 21, hour: 18, minute:  0, second:  0)),
                    ]
                    let dataProcessor = CCDStayLaboDataProcessor(stayLaboDataList: stayLaboDataList)
                    processedData = dataProcessor.processStayLaboData()
                }
                it(IT.ProceededValue.rawValue) {
                    expect(processedData.totalByMonth[CCDMonth.June.hashValue]).to(equal(           9 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Sunday.hashValue]).to(equal(     9 * 3600 +  0      +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Monday.hashValue]).to(equal(     0 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Tuesday.hashValue]).to(equal(    0 * 3600 +  0      +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Wednesday.hashValue]).to(equal(  0 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Thursday.hashValue]).to(equal(   0 * 3600 +  0      +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Friday.hashValue]).to(equal(     0 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Saturday.hashValue]).to(equal(   0 * 3600 +  0 * 60 +  0))
                }
                it(IT.NumberOfDay.rawValue) {
                    expect(processedData.numberByMonth).to(equal([0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0]))
                    expect(processedData.numberByWeekday).to(equal([1, 0, 0, 0, 0, 0, 0]))
                }
            }

            context("when data are on the same day") {
                beforeEach {
                    let stayLaboDataList = [
                        //Sunday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 21, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 21, hour:  0, minute:  0, second: 10)),
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 21, hour:  1, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 21, hour:  1, minute:  0, second: 10)),
                        //Monday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 22, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 22, hour:  0, minute: 10, second:  0)),
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 22, hour:  1, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 22, hour:  1, minute: 10, second:  0)),
                        //Wednesday
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 24, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 24, hour:  0, minute: 10, second: 10)),
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 24, hour:  1, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 24, hour:  1, minute: 10, second: 10)),
                    ]
                    let dataProcessor = CCDStayLaboDataProcessor(stayLaboDataList: stayLaboDataList)
                    processedData = dataProcessor.processStayLaboData()
                }
                it(IT.ProceededValue.rawValue) {
                    expect(processedData.totalByMonth[CCDMonth.June.hashValue]).to(equal(           0 * 3600 + 40 * 60 + 40))
                    expect(processedData.totalByWeekday[CCDWeekday.Sunday.hashValue]).to(equal(     0 * 3600 +  0 * 60 + 20))
                    expect(processedData.totalByWeekday[CCDWeekday.Monday.hashValue]).to(equal(     0 * 3600 + 20 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Tuesday.hashValue]).to(equal(    0 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Wednesday.hashValue]).to(equal(  0 * 3600 + 20 * 60 + 20))
                    expect(processedData.totalByWeekday[CCDWeekday.Thursday.hashValue]).to(equal(   0 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Friday.hashValue]).to(equal(     0 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Saturday.hashValue]).to(equal(   0 * 3600 +  0 * 60 +  0))
                }
                it(IT.NumberOfDay.rawValue) {
                    expect(processedData.numberByMonth).to(equal([0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0]))
                    expect(processedData.numberByWeekday).to(equal([1, 1, 1, 1, 0, 0, 0]))
                }
            }

            context("when data extends the following month") {
                beforeEach {
                    let stayLaboDataList = [
                        //Tuesday(June)
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 30, hour:  0, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .June     , day: 30, hour:  0, minute:  0, second: 10)),
                        //Tuesday(June) -> Wednesday(July)
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 30, hour:  20, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .July     , day:  1, hour:   5, minute:  0, second:  0)),
                        //Tuesday(June) -> Wednesday(July)
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 30, hour:  22, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .July     , day:  1, hour:   4, minute:  0, second:  0)),
                        //Tuesday(June) -> Wednesday(July)
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .June     , day: 30, hour:  23, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .July     , day:  1, hour:   6, minute:  0, second:  0)),
                        //Wednesday(July)
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .July     , day:  1, hour:   9, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .July     , day:  1, hour:  17, minute:  0, second:  0)),
                        //Wednesday(July)
                        CCDStayLaboData(
                            laboinDate:   self.makeNSDate(2015, month: .July     , day:  1, hour:  18, minute:  0, second:  0),
                            laboridaDate: self.makeNSDate(2015, month: .July     , day:  1, hour:  19, minute:  0, second:  0)),
                    ]
                    let dataProcessor = CCDStayLaboDataProcessor(stayLaboDataList: stayLaboDataList)
                    processedData = dataProcessor.processStayLaboData()
                }
                it(IT.ProceededValue.rawValue) {
                    expect(processedData.totalByMonth[CCDMonth.June.hashValue]).to(equal(           4 * 3600 +  0 * 60 + 10))
                    expect(processedData.totalByMonth[CCDMonth.July.hashValue]).to(equal(          15 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Sunday.hashValue]).to(equal(     0 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Monday.hashValue]).to(equal(     0 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Tuesday.hashValue]).to(equal(    4 * 3600 +  0 * 60 + 10))
                    expect(processedData.totalByWeekday[CCDWeekday.Wednesday.hashValue]).to(equal( 15 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Thursday.hashValue]).to(equal(   0 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Friday.hashValue]).to(equal(     0 * 3600 +  0 * 60 +  0))
                    expect(processedData.totalByWeekday[CCDWeekday.Saturday.hashValue]).to(equal(   0 * 3600 +  0 * 60 +  0))
                }
                it(IT.NumberOfDay.rawValue) {
                    expect(processedData.numberByMonth).to(equal([0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0]))
                    expect(processedData.numberByWeekday).to(equal([0, 0, 1, 1, 0, 0, 0]))
                }
            }
        }
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