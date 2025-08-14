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
    let startDateComponents: DateComponents
    let firstDayOfMonth: Date
    let startWeekday: Int
    let calendarStart: Date
    var calendarEnd: Date
    let weeksShown: Int = 5
    var monthDays: [Date] = []
    // Create dict of saved dates and the corresponding Day model to feed into DayViewModel
    // if it exists for specific date in calendar
    var savedDaysDict: [Date: Day] {
        Dictionary(uniqueKeysWithValues: days.map { ($0.date, $0) })
    }
    
    init(year: Int, month: Int) {
        self.startDateComponents = DateComponents(calendar: Calendar.current, year: year, month: month, day: 1)
        self.firstDayOfMonth = Calendar.current.date(from: startDateComponents) ?? Date()
        // Calendar always starts on Sunday, so need to adjust first date in month to the nearest Sunday
        self.startWeekday = Calendar.current.component(.weekday, from: firstDayOfMonth)
        self.calendarStart = Calendar.current.date(byAdding: .day, value: 1 - startWeekday, to: firstDayOfMonth)!
        self.calendarEnd = Calendar.current.date(byAdding: .weekOfMonth, value: 5, to: calendarStart)!
        // Swift uses start of following day as end date, so need to subtract one day
        calendarEnd = Calendar.current.date(byAdding: .day, value: -1, to: calendarEnd)!
        monthDays = generateMonth()
        
        // Introduce compound predicate for days query
        _days = Query(filter: #Predicate<Day> { $0.date >= calendarStart && $0.date <= calendarEnd} )
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
    
    func generateMonth() -> [Date] {
        var monthDates: [Date] = []
        for i in 0..<7 * weeksShown {
            let currentDate = Calendar.current.date(byAdding: .day, value: i, to: calendarStart) ?? Date()
            monthDates.append(currentDate)
        }
        return monthDates
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
