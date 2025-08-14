//
//  MonthView.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/28/25.
//

import SwiftUI
import SwiftData

struct MonthView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \Location.createDate) var locations: [Location]
    @Query(sort: \Day.date) var days: [Day]
    let year: Int
    let month: Int
    let weeksShown: Int = 5
    var startDateComponents: DateComponents {
        DateComponents(calendar: Calendar.current, year: year, month: month, day: 1)
    }
    var firstDayOfMonth: Date {
        Calendar.current.date(from: startDateComponents) ?? Date()
    }
    var startWeekday: Int {
        Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
    var calendarStart: Date {
        // Calendar always starts on Sunday, so need to adjust first date in month to the nearest Sunday
        Calendar.current.date(byAdding: .day, value: 1 - startWeekday, to: firstDayOfMonth)!
    }
    var calendarEnd: Date {
        // Swift uses start of following day as end date, so need to subtract one day
        Calendar.current.date(byAdding: .day, value: (weeksShown * 7) - 1, to: calendarStart)!
    }
    var monthDays: [Date] {
        (0..<weeksShown * 7).compactMap {
            Calendar.current.date(byAdding: .day, value: $0, to: calendarStart)
        }
    }

    // Create dict of saved dates and the corresponding Day model to feed into DayViewModel
    // if it exists for specific date in calendar
    var savedDaysDict: [Date: Day] {
        Dictionary(uniqueKeysWithValues: days.map { ($0.date, $0) })
    }

    var body: some View {
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
                ForEach(0..<weeksShown, id: \.self) { row in
                    GridRow {
                        ForEach(0..<7) { day in
                            let monthDate = monthDays[row * 7 + day]
                            let dayModel = savedDaysDict[monthDate]
                            let dayViewModel = DayViewModel(day: dayModel, date: monthDate,
                                                            month: firstDayOfMonth, locations: locations)
                            DayView(dayViewModel: dayViewModel)
                        }
                        .border(Color(.gray), width: 0.2)
                    }
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Location.self, configurations: config)
        let example = Day(date: Date(), location: nil)
        container.mainContext.insert(example)
        return MonthView(year: 2025, month: 7)
    } catch {
        fatalError("Failed to create model container.")
    }
}
