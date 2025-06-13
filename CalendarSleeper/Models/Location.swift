//
//  Location.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/27/25.
//

import Foundation
import SwiftUI

class Location: Identifiable {
    let name: String
    let primaryColor: Color
    let targetDays: Int?
    var currentDays: Int = 0
    
    init(name: String, primaryColor: Color, targetDays: Int?, currentDays: Int) {
        self.name = name
        self.primaryColor = primaryColor
        self.targetDays = targetDays
        self.currentDays = currentDays
    }
}
