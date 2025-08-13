//
//  Day.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/28/25.
//

import Foundation
import SwiftData

@Model
class Day {
    @Attribute(.unique) var date: Date
    @Relationship var location: Location?
    
    init(date: Date, location: Location?) {
        self.date = date
        self.location = location
    }
}
