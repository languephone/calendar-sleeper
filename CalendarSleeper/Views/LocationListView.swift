//
//  LocationListView.swift
//  CalendarSleeper
//
//  Created by Daniel Shapiro on 5/30/25.
//

import SwiftUI

struct LocationListView: View {
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("Add new location")
                    Spacer()
                    Image(systemName: "plus")
                }
                NavigationLink {
                    Text("Edit location")
                } label: {
                    HStack {
                        Text("Location 1")
                    }
                }
                NavigationLink {
                    Text("Edit location")
                } label: {
                    HStack {
                        Text("Location 2")
                    }
                }
            }
            .navigationTitle("Edit Locations")
        }
    }
}

#Preview {
    LocationListView()
}
