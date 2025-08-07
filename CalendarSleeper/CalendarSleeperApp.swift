//
//  CalendarSleeperApp.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/27/25.
//

import SwiftData
import SwiftUI

@main
struct CalendarSleeperApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Location.self])
        }
    }
}
