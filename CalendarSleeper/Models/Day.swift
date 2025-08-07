//
//  Day.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/28/25.
//

import Foundation
import SwiftData

//@Model
class Day {
    var location: Location?
    var id = UUID()
    var date: Date
    var dateComponents: DateComponents
    
    init(date: Date, location: Location?) {
        self.location = location
        self.date = date
        self.dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
    }

    func isWithinMonth(_ dayInMonth: Date) -> Bool {
        Calendar.current.isDate(date, equalTo: dayInMonth, toGranularity: .month)
    }

    func toggleLocation(_ newLocation: Location?) {
        if location == nil {
            location = newLocation
        } else {
            location = nil
        }
    }
}
