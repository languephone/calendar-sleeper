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
    @State var locations: [Location] = []
    let monthNames = Calendar.current.monthSymbols

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
                            ForEach(selectedYear - 1...selectedYear + 1, id: \.self) { year in
                                Text(String(year)).tag(year)
                            }
                        }
                    }
                    MonthView(month: Month(year: selectedYear, month: selectedMonth))
                }
            }
            Tab("Locations", systemImage: "location.magnifyingglass") {
                LocationListView(locations: $locations)
            }
        }
    }
}

#Preview {
    ContentView()
}
