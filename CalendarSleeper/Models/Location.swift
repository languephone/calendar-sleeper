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
    var targetDays: Int?
    var currentDays: Int
    @Relationship(deleteRule: .cascade, inverse: \Day.location)
    var days: [Day] = []
    @Attribute var createDate: Date = Date()
    
    init(name: String, targetDays: Int?, currentDays: Int = 0) {
        self.name = name
        self.targetDays = targetDays
        self.currentDays = currentDays
    }
}
