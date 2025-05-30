//
//  ContentView.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/27/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Calendar", systemImage: "calendar") {
                MonthView(monthViewModel: MonthViewModel(year: 2025, month: 8))
            }
            Tab("Input", systemImage: "pencil.and.outline") {
                Text("Input item here")
            }
        }
    }
}

#Preview {
    ContentView()
}
