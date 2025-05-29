//
//  MonthView.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/28/25.
//

import SwiftUI

struct MonthView: View {
    let monthViewModel = MonthViewModel(year: 2025, month: 5)
    var body: some View {
        let weeks = monthViewModel.generateMonth()
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
            GridRow {
                ForEach(weeks[0]) { day in
                        DayView(dayViewModel: day)
                }
                .padding(0)
            }
            GridRow {
                ForEach(weeks[1]) { day in
                        DayView(dayViewModel: day)
                }
            }
            GridRow {
                ForEach(weeks[2]) { day in
                        DayView(dayViewModel: day)
                }
            }
            GridRow {
                ForEach(weeks[3]) { day in
                        DayView(dayViewModel: day)
                }
            }
            GridRow {
                ForEach(weeks[4]) { day in
                        DayView(dayViewModel: day)
                }
            }
        }
    }
}

#Preview {
    MonthView()
}
