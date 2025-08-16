//
//  ContentView.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/27/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedTab = "Calendar"
    @State private var locationPath = NavigationPath()
    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    let monthNames = Calendar.current.monthSymbols

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Calendar", systemImage: "calendar", value: "Calendar") {
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
                    MonthView(year: selectedYear, month: selectedMonth)
                        .id("\(selectedYear)-\(selectedMonth)")
                }
            }
            
            Tab("Locations", systemImage: "location.magnifyingglass", value: "Locations") {
                NavigationStack(path: $locationPath) {
                    LocationListView()
                }
            }
        }
        .onChange(of: selectedTab) { oldValue, newValue in
            if newValue == "Locations" {
                // Reset navigation when the Locations tab is activated to
                // force a data fetch and prevent the user from seeing an
                // outdated 'currentDays' value in the LocationView
                print("Changed to Locations")
                locationPath = NavigationPath()
            }
        }
    }
}

#Preview {
    ContentView()
}
