//
//  DayView.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/27/25.
//

import SwiftUI

struct DayView: View {
    @State var dayViewModel: DayViewModel
    let month: Date
    
    var body: some View {
        VStack {
            HStack {
                Text("\(dayViewModel.dateComponents.day!)")
                    .foregroundStyle(dayViewModel.isWithinMonth(month) ? .black : .gray)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
        }
        .padding(5)
        // Conditionally use location's background colour
        .background(Color(dayViewModel.location?.primaryColor ?? .white))
        .onTapGesture {
            dayViewModel.toggleLocation(newLocation: Location(name: "New York", primaryColor: .yellow, targetDays: 180, currentDays: 0))
        }
    }
}

#Preview {
//    let testLocation = Location(name: "New York", primaryColor: .yellow, targetDays: 180, currentDays: 0)
    let dayViewModel = DayViewModel(date: Date(), location: nil)
    DayView(dayViewModel: dayViewModel, month: Date())
        .frame(width: 100, height: 150)
        .border(.gray)
}
