//
//  DayView.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/27/25.
//

import SwiftUI

struct DayView: View {
    let location: Location
    let components: DateComponents
    let day: Int

    init(day: Date, location: Location) {
        self.location = location
        self.components = Calendar.current.dateComponents([.day, .month], from: day)
        self.day = self.components.day ?? 1
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Text("\(day)")
                    .foregroundStyle(.gray)
                Spacer()
            }
            Spacer()
            Text(location.name)
                .font(.caption)
                .padding([.leading, .trailing], 15)
                .background(Color(location.primaryColor))
                .cornerRadius(5)
                .padding()
        }
        .frame(width: 100, height: 100, alignment: .leading)
        .padding()
        .border(Color.gray)
    }
}

#Preview {
    let testLocation = Location(name: "New York", primaryColor: .yellow, targetDays: 180, currentDays: 0)
    DayView(day: Date(), location: testLocation)
}
