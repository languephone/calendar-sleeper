//
//  DayView.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/27/25.
//

import SwiftUI

struct DayView: View {
    let dayViewModel: DayViewModel
    let month: Date
    
    var body: some View {
        VStack {
            HStack {
                Text("\(dayViewModel.dateComponents.day!)")
                    .foregroundStyle(dayViewModel.isWithinMonth(month) ? .black : .gray)
                    .font(.caption)
                Spacer()
            }
            Spacer()
            RoundedRectangle(cornerRadius: 5)
        }
        .padding(5)
    }
}

#Preview {
    let testLocation = Location(name: "New York", primaryColor: .yellow, targetDays: 180, currentDays: 0)
    let dayViewModel = DayViewModel(date: Date(), location: testLocation)
    DayView(dayViewModel: dayViewModel, month: Date())
        .frame(width: 100, height: 150)
        .border(.gray)
}
