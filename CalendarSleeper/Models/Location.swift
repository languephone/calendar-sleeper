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
    var currentDays: Int
    var createDate: Date = Date.now
    
    init(name: String, targetDays: Int = 0, currentDays: Int = 0) {
        self.name = name
        self.targetDays = targetDays
        self.currentDays = currentDays
    }
}
