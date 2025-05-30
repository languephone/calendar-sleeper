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
            Text("Month \(monthViewModel.startDateComponents.month!)")
                .font(.title)
            Text(String(monthViewModel.startDateComponents.year!))
                .font(.title2)
                .padding([.bottom], 20)
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                GridRow {
                    Text("Sun")
                    Text("Mon")
                    Text("Tue")
                    Text("Wed")
                    Text("Thu")
                    Text("Fri")
                    Text("Sat")
                }
                .font(.caption)
                ForEach(0..<monthViewModel.weeksShown, id: \.self) { row in
                    GridRow {
                        ForEach(0..<7) { day in
                            DayView(dayViewModel: monthDays[row * 7 + day], month: monthViewModel.firstDayOfMonth)
                        }
                        .padding(0)
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
