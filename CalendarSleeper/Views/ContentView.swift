//
//  ContentView.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/27/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    let monthNames = Calendar.current.monthSymbols
    let yearRange = Array(2023...2026)

    var body: some View {
        TabView {
            Tab("Calendar", systemImage: "calendar") {
                VStack(alignment: .leading) {
                    HStack {
                        Picker("Month", selection: $selectedMonth) {
                            ForEach(1...12, id: \.self) { month in
                                Text(monthNames[month - 1])
                                    .tag(month)
                            }
                        }
                        Picker("Year", selection: $selectedYear) {
                            ForEach(yearRange, id: \.self) { year in
                                Text(String(year)).tag(year)
                            }
                        }
                    }
                    MonthView(monthViewModel: MonthViewModel(year: selectedYear, month: selectedMonth))
                }
            }
            Tab("Input", systemImage: "pencil.and.outline") {
                LocationListView()
            }
        }
    }
}

#Preview {
    ContentView()
}
