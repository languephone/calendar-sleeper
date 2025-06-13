//
//  Location.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/27/25.
//

import Foundation
import SwiftUI

class Location: ObservableObject, Identifiable {
    var name: String
    var primaryColor: Color
    @Published var targetDays: Int?
    var currentDays: Int = 0
    
    init(name: String, primaryColor: Color, targetDays: Int?, currentDays: Int) {
        self.name = name
        self.primaryColor = primaryColor
        self.targetDays = targetDays
        self.currentDays = currentDays
    }
}
