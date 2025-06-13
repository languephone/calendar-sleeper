//
//  MonthView.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/28/25.
//

import SwiftUI

struct MonthView: View {
    let month: Month
    var body: some View {
        let monthDays = month.generateMonth()
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
                ForEach(0..<month.weeksShown, id: \.self) { row in
                    GridRow {
                        ForEach(0..<7) { day in
                            DayView(day: monthDays[row * 7 + day], month: month.firstDayOfMonth)
                        }
                        .border(Color(.gray), width: 0.2)
                    }
                }
            }
        }
    }
}

#Preview {
    MonthView(month: Month(year: 2025, month: 7))
}
