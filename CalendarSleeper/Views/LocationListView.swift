//
//  LocationListView.swift
//  CalendarSleeper
//
//  Created by Daniel Shapiro on 5/30/25.
//

import SwiftUI
import SwiftData

struct LocationListView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \Location.createDate, order: .reverse) var locations: [Location]

    var body: some View {
        NavigationView {
            List {
//                 Option to add new locations
                HStack {
                    Text("Add new location")
                    Spacer()
                    Image(systemName: "plus")
                }
                .onTapGesture {}
                // Actual locations
                ForEach(locations) { location in
                    NavigationLink {
                        LocationView(location: location)
                    } label: {
                        Text(location.name)
                    }
                }
            }
            .navigationTitle("Edit Locations")
            .toolbar {
                Button(action: {
                    let newLocation = Location(name: "", targetDays: nil)
                    context.insert(newLocation)
                }, label: {
                    Image(systemName: "plus")
                })
            }
        }
    }
}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Location.self, configurations: config)
        let example = Location(name: "Test", targetDays: 50, currentDays: 0)
        container.mainContext.insert(example)
        return LocationListView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
