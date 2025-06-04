//
//  MonthView.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/28/25.
//

import SwiftUI

struct MonthView: View {
    let monthViewModel: MonthViewModel
    var body: some View {
        let monthDays = monthViewModel.generateMonth()
        VStack(alignment: .leading) {
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                // Header row containing weekday names
                GridRow {
                    ForEach(Calendar.current.weekdaySymbols, id: \.self) { day in
                        Text(day.prefix(3))
                    }
                }
                .font(.caption)
                .padding(.bottom, 5)
                // Rest of grid with days of month
                ForEach(0..<monthViewModel.weeksShown, id: \.self) { row in
                    GridRow {
                        ForEach(0..<7) { day in
                            DayView(dayViewModel: monthDays[row * 7 + day], month: monthViewModel.firstDayOfMonth)
                        }
                        .border(Color(.gray), width: 0.2)
                    }
                }
            }
        }
    }
}

#Preview {
    MonthView(monthViewModel: MonthViewModel(year: 2025, month: 7))
}
