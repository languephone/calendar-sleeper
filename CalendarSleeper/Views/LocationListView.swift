//
//  LocationListView.swift
//  CalendarSleeper
//
//  Created by Daniel Shapiro on 5/30/25.
//

import SwiftUI

struct LocationListView: View {
    @Binding var locations: [Location]

    var body: some View {
        NavigationView {
            List {
                // Option to add new locations
                HStack {
                    Text("Add new location")
                    Spacer()
                    Image(systemName: "plus")
                }
                .onTapGesture {
                    locations.append(Location(name: "New Location", primaryColor: .yellow, targetDays: 100, currentDays: 0))
                }
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
        }
    }
}

#Preview {
    @Previewable @State var locations: [Location] = [
        Location(name: "London", primaryColor: .blue, targetDays: 120, currentDays: 0),
        Location(name: "New York", primaryColor: .green, targetDays: 50, currentDays: 0)
    ]
    LocationListView(locations: $locations)
}
