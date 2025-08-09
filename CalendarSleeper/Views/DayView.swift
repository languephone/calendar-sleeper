//
//  DayView.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/27/25.
//

import SwiftUI
import SwiftData

struct DayView: View {
    @State var location: Location?
    @State private var locationPickerPresented: Bool = false
    let day: Day
    let month: Date
    @Query var locations: [Location]

    
    var body: some View {
        Button(action: {
            locationPickerPresented.toggle()
        }) {
            VStack{
                Text("\(day.dateComponents.day!)")
                    .foregroundStyle(day.isWithinMonth(month) ? .black : .gray)
                    .font(.caption)
                    .padding(5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                // Display chosen location if it exists
                if let location {
                    Text(location.name)
                        .font(.subheadline)
                }
            }
        }
        .popover(isPresented: $locationPickerPresented) {
            // Becuase location var is optional and items in locations array are not,
            // need to cast tag as Location? type.
            Picker(selection: $location, label: Text("Location")) {
                Text("Select location").tag(nil as Location?)
                ForEach(locations, id: \.self) { location in
                    Text(location.name).tag(location as Location?)
                }
            }
            .pickerStyle(.wheel)
            .presentationCompactAdaptation(.popover)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Location.self, configurations: config)
        let example1 = Location(name: "Test City", targetDays: 50, currentDays: 0)
        let example2 = Location(name: "Charleston", targetDays: 15, currentDays: 20)
        container.mainContext.insert(example1)
        container.mainContext.insert(example2)
        let day = Day(date: Date(), location: nil)
        
        return DayView(day: day, month: Date())
            .modelContainer(container)
            .frame(width: 100, height: 150)
            .border(.gray)
    } catch {
        fatalError("Failed to create model container.")
    }
}
