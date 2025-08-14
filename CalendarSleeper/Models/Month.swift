//
//  Month.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/28/25.
//

import Foundation
import SwiftData

@Observable
class Month {
    let startDateComponents: DateComponents
    let firstDayOfMonth: Date
    let startWeekday: Int
    let calendarStart: Date
    var calendarEnd: Date
    let weeksShown: Int = 5
    var monthDays: [Day] = []

    init(year: Int, month: Int) {
        self.startDateComponents = DateComponents(calendar: Calendar.current, year: year, month: month, day: 1)
        self.firstDayOfMonth = Calendar.current.date(from: startDateComponents) ?? Date()
        // Calendar always starts on Sunday, so need to adjust first date in month to the nearest Sunday
        self.startWeekday = Calendar.current.component(.weekday, from: firstDayOfMonth)
        self.calendarStart = Calendar.current.date(byAdding: .day, value: 1 - startWeekday, to: firstDayOfMonth)!
        self.calendarEnd = Calendar.current.date(byAdding: .weekOfMonth, value: 5, to: calendarStart)!
        // Swift uses start of following day as end date, so need to subtract one day
        calendarEnd = Calendar.current.date(byAdding: .day, value: -1, to: calendarEnd)!
    }
    
    func generateMonth(savedDays: [Day]) -> [Day] {
        var monthDates: [Day] = []
        for i in 0..<7 * weeksShown {
            let currentDate = Calendar.current.date(byAdding: .day, value: i, to: calendarStart)
            monthDates.append(
                Day(date: currentDate!, location: nil)
            )
        }
        return monthDates
    }
}
