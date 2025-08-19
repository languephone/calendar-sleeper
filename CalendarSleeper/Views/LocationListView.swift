//
//  LocationListView.swift
//  CalendarSleeper
//
//  Created by Daniel Shapiro on 5/30/25.
//

import SwiftData
import SwiftUI

struct LocationListView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \Location.createDate) var locations: [Location]

    var body: some View {
        // Already in a navigation stack from the parent view,
        // so no need to re-define NavigationStack
        List {
            ForEach(locations) { location in
                NavigationLink(value: location) {
                    VStack(alignment: .leading) {
                        Text(location.name)
                        Text(
                            "Created: \(location.createDate.formatted(date: .abbreviated, time: .omitted))"
                        )
                        .font(.caption)
                    }
                }
            }
            .onDelete(perform: deleteLocations)
        }
        .navigationTitle("Saved Locations")
        .navigationDestination(
            for: Location.self,
            destination: { location in
                LocationView(location: location, tempTargetDays: Double(location.targetDays))
            }
        )
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            ToolbarItem {
                Button(
                    action: createLocation,
                    label: {
                        Image(systemName: "plus")
                    }
                )
            }
        }
    }

    func createLocation() {
        let newLocation = Location(name: "Location \(locations.count + 1)")
        context.insert(newLocation)
    }

    func deleteLocations(_ indexSet: IndexSet) {
        for index in indexSet {
            let location = locations[index]
            context.delete(location)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(
            for: Location.self,
            configurations: config
        )
        let example = Location(name: "Test City", targetDays: 50)
        container.mainContext.insert(example)
        return LocationListView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
