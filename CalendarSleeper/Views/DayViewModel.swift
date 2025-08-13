//
//  DayViewModel.swift
//  CalendarSleeper
//
//  Created by Daniel Shapiro on 8/9/25.
//

import Foundation
import SwiftUI

@Observable
class DayViewModel {
    var day: Day?
    let date: Date
    let month: Date
    let dateComponents: DateComponents
    var locations: [Location]
    var locationPickerPresented: Bool = false
    // Because both Day and Day.Location are optionals,
    // need to create a 
    var locationBinding: Binding<Location?> {
        Binding(
            get: { self.day?.location },
            set: { self.day?.location = $0 }
        )
    }
    
    init(day: Day?, date: Date, month: Date, locations: [Location]) {
        self.day = day
        self.date = date
        self.month = month
        self.locations = locations
        self.dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
    }

    func isWithinMonth() -> Bool {
        Calendar.current.isDate(date, equalTo: month, toGranularity: .month)
    }
    
}
