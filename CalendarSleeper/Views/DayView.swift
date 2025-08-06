//
//  DayView.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/27/25.
//

import SwiftUI

struct DayView: View {
    @State var day: Day
    let month: Date
    let location: Location = Location(name: "New York", targetDays: 180, currentDays: 0)
    
    var body: some View {
        VStack {
            HStack {
                Text("\(day.dateComponents.day!)")
                    .foregroundStyle(day.isWithinMonth(month) ? .black : .gray)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
        }
        .padding(5)
        .onTapGesture {
            day.toggleLocation(location)
        }
    }
}

#Preview {
    let day = Day(date: Date(), location: nil)
    DayView(day: day, month: Date())
        .frame(width: 100, height: 150)
        .border(.gray)
}
