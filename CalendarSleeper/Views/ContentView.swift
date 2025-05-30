//
//  ContentView.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/27/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MonthView(monthViewModel: MonthViewModel(year: 2025, month: 8))
    }
}

#Preview {
    ContentView()
}
