//
//  Day.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/28/25.
//

import Foundation

struct DayViewModel: Identifiable {
    let id = UUID()
    let date: Date
    let location: Location?
    let dateComponents: DateComponents
    
    init(date: Date, location: Location?) {
        self.date = date
        self.location = location
        self.dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
    }

    func isWithinMonth(_ dayInMonth: Date) -> Bool {
        Calendar.current.isDate(date, equalTo: dayInMonth, toGranularity: .month)
    }
}
