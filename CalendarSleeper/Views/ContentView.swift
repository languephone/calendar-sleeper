//
//  ContentView.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/27/25.
//

import SwiftUI

struct ContentView: View {
    @State var monthChoice = MonthChoices.may
    var body: some View {
        TabView {
            Tab("Calendar", systemImage: "calendar") {
                VStack(alignment: .leading) {
                    Picker("Month", selection: $monthChoice) {
                        ForEach(MonthChoices.allCases, id: \.self) {month in
                            Text(month.rawValue.capitalized)
                        }
                    }
                    MonthView(monthViewModel: MonthViewModel(year: 2025, month: 8))
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
