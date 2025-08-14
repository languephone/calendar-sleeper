//
//  DayView.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 5/27/25.
//

import SwiftUI
import SwiftData

struct DayView: View {
    @Environment(\.modelContext) var context
    @State var dayViewModel: DayViewModel
    
    var body: some View {
        Button(action: {
            // If no Day model exists for date, create it and insert into context
            if dayViewModel.day == nil {
                dayViewModel.day = Day(date: dayViewModel.date, location: nil)
                context.insert(dayViewModel.day!) // Safe to unwrap because day defined on prior line
            }
            dayViewModel.locationPickerPresented.toggle()
            
        }) {
            VStack{
                Text("\(dayViewModel.dateComponents.day!)")
                    .foregroundStyle(dayViewModel.isWithinMonth() ? .black : .gray)
                    .font(.caption)
                    .padding(5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                // Display chosen location if it exists
                if let day = dayViewModel.day, let location = day.location {
                    Text(location.name)
                        .font(.subheadline)
                }
            }
        }
        .popover(isPresented: $dayViewModel.locationPickerPresented) {
            // Becuase location var is optional and items in locations array are not,
            // need to cast tag as Location? type.
            Picker(selection: Binding(get: { dayViewModel.day?.location },
                                      set: { newLocation in dayViewModel.day?.location = newLocation }),
                   label: Text("Location")) {
                Text("Select location").tag(nil as Location?)
                ForEach(dayViewModel.locations, id: \.self) { location in
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
        let example1 = Location(name: "Savannah", targetDays: 50)
        let example2 = Location(name: "Charleston", targetDays: 15)
        container.mainContext.insert(example1)
        container.mainContext.insert(example2)
        let dayViewModel = DayViewModel(day: nil, date: Date(), month: Date(), locations: [example1, example2])
        
        return DayView(dayViewModel: dayViewModel)
            .modelContainer(container)
            .frame(width: 100, height: 150)
            .border(.gray)
    } catch {
        fatalError("Failed to create model container.")
    }
}
