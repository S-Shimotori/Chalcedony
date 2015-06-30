//
//  CCDDataModel.swift
//  Chalcedony
//
//  Created by S-Shimotori on 6/28/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit

class CCDDataModel {
    private let stayLaboDataList: [CCDStayLaboData]
    private let dateFormatter = NSDateFormatter()
    private let calendar = NSCalendar.currentCalendar()
    private let unitFlags: NSCalendarUnit =
        .CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitWeekday |
            .CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond

    init(stayLaboDataList: [CCDStayLaboData]) {
        self.stayLaboDataList = stayLaboDataList
    }

    func calculateStayLaboData() -> CCDCalculatedData {
        var numberByWeekday = [Int](count: 7, repeatedValue: 0)
        var numberByMonth = [Int](count: 12, repeatedValue: 0)
        var totalByWeekday = [Double](count: 7, repeatedValue: 0)
        var totalByMonth = [Double](count: 12, repeatedValue: 0)

        var sortedStayLaboDataList = stayLaboDataList
        sortedStayLaboDataList.sort(<)

        var lastLaboridaDate: NSDate?
        for stayLaboData in sortedStayLaboDataList {
            //らぼりだ時間が前データらぼりだ時間と同じかそれより前なら
            if let lastLaboridaDate = lastLaboridaDate where stayLaboData.laboridaDate.compare(lastLaboridaDate) != .OrderedDescending {
                continue
            }

            //らぼいん時間が前データらぼりだ時間より前なら
            let laboridaDate = stayLaboData.laboridaDate
            let laboinDate: NSDate
            if let lastLaboridaDate = lastLaboridaDate where stayLaboData.laboinDate.compare(lastLaboridaDate) == .OrderedAscending {
                laboinDate = lastLaboridaDate
            } else {
                laboinDate = stayLaboData.laboinDate
            }

            //もし前データが存在するなら
            if let lastLaboridaDate = lastLaboridaDate {
                //前データらぼりだの翌日の日付を取得
                var components = calendar.components(unitFlags, fromDate: lastLaboridaDate)
                components.day++
                var dayAfterLastLaboridaDate = calendar.dateFromComponents(components)!

                //同じ日になるまでカウント
                while dayAfterLastLaboridaDate.isAscendingWithoutTime(laboinDate) {
                    //曜日カウント
                    numberByWeekday[dayAfterLastLaboridaDate.date().weekday - 1]++
                    //月代わりに月カウント
                    if dayAfterLastLaboridaDate.date().day == 1 {
                        numberByMonth[dayAfterLastLaboridaDate.date().month - 1]++
                    }

                    //次の日へ
                    components = calendar.components(unitFlags, fromDate: dayAfterLastLaboridaDate)
                    components.day++
                    dayAfterLastLaboridaDate = calendar.dateFromComponents(components)!
                }

            } else {
                //月母数カウント
                if laboinDate.date().day != 1 {
                    numberByMonth[laboinDate.date().month - 1]++
                }
            }

            //らぼいんとりだが同じ日
            if laboinDate.isEqualWithoutTime(laboridaDate) {
                let howManySecondsStay = laboridaDate.timeIntervalSinceDate(laboinDate)
                totalByWeekday[laboinDate.date().weekday - 1] += howManySecondsStay
                totalByMonth[laboinDate.date().month - 1] += howManySecondsStay

                if let lastLaboridaDate = lastLaboridaDate where !laboinDate.isEqualWithoutTime(lastLaboridaDate) {
                    numberByWeekday[laboinDate.date().weekday - 1]++
                    if laboinDate.date().day == 1 {
                        numberByMonth[laboinDate.date().month - 1]++
                    }
                } else if lastLaboridaDate == nil {
                    numberByWeekday[laboinDate.date().weekday - 1]++
                    if laboinDate.date().day == 1 {
                        numberByMonth[laboinDate.date().month - 1]++
                    }
                }
            } else {
                //翌日の日付午前0時
                var components = calendar.components(unitFlags, fromDate: laboinDate)
                components.day++
                components.hour = 0
                components.minute = 0
                components.second = 0
                var date0 = laboinDate
                var date1 = calendar.dateFromComponents(components)!
                //終了日になるまでカウント
                while !date1.isDescendingWithoutTime(laboridaDate) {
                    let howManySecondsStay = date1.timeIntervalSinceDate(date0)
                    totalByWeekday[date0.date().weekday - 1] += howManySecondsStay
                    if let lastLaboridaDate = lastLaboridaDate where !date0.isEqualWithoutTime(lastLaboridaDate) {
                        numberByWeekday[date0.date().weekday - 1]++
                    } else if lastLaboridaDate == nil {
                        numberByWeekday[date0.date().weekday - 1]++
                    }
                    totalByMonth[date0.date().month - 1] += howManySecondsStay
                    if date0.date().day == 1 {
                        numberByMonth[date0.date().month - 1]++
                    }

                    components = calendar.components(unitFlags, fromDate: date1)
                    components.day++
                    components.hour = 0
                    components.minute = 0
                    components.second = 0
                    date0 = date1
                    date1 = calendar.dateFromComponents(components)!
                }
                //終了日の時刻計算
                let howManySecondsStay = laboridaDate.timeIntervalSinceDate(date0)
                totalByWeekday[laboridaDate.date().weekday - 1] += howManySecondsStay
                numberByWeekday[laboridaDate.date().weekday - 1]++
                totalByMonth[laboridaDate.date().month - 1] += howManySecondsStay
                if laboridaDate.date().day == 1 {
                    numberByMonth[laboridaDate.date().month - 1]++
                }
            }
            lastLaboridaDate = laboridaDate
        }
        return CCDCalculatedData(numberByWeekday: numberByWeekday, numberByMonth: numberByMonth, totalByWeekday: totalByWeekday, totalByMonth: totalByMonth)
    }
}