//
//  DayView.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/27/25.
//

import SwiftUI

struct DayView: View {
    let dayViewModel: DayViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("\(dayViewModel.dateComponents.day!)")
                    .foregroundStyle(.gray)
                    .font(.caption)
                Spacer()
            }
            Spacer()
            RoundedRectangle(cornerRadius: 5)
        }
        .frame(width: 25, height: 30, alignment: .leading)
        .padding()
        .border(Color.gray)
    }
}

#Preview {
    let testLocation = Location(name: "New York", primaryColor: .yellow, targetDays: 180, currentDays: 0)
    let dayViewModel = DayViewModel(date: Date(), location: testLocation)
    DayView(dayViewModel: dayViewModel)
}
