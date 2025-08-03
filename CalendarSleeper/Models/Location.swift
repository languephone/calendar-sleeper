//
//  Location.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/27/25.
//

import Foundation
import SwiftUI

class Location: ObservableObject, Identifiable {
    @Published var name: String
    @Published var targetDays: Int?
    @Published var currentDays: Int = 0
    @Published var days: [Day] = []
    
    init(name: String, targetDays: Int?, currentDays: Int) {
        self.name = name
        self.targetDays = targetDays
        self.currentDays = currentDays
    }
}
