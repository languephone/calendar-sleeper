//
//  Location.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/27/25.
//

import Foundation
import SwiftData

@Model
class Location {
    @Attribute(.unique) var name: String
    var targetDays: Int
    var createDate: Date
    @Relationship(deleteRule: .cascade, inverse: \Day.location)
    var days: [Day]
    
    var currentDays: Int {
        days.count
    }
    
    init(name: String, targetDays: Int = 0) {
        self.name = name
        self.targetDays = targetDays
        self.createDate = Date.now
        self.days = []
    }
}
