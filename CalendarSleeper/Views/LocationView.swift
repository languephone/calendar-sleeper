//
//  LocationView.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 6/13/25.
//

import SwiftUI

struct LocationView: View {
    @Bindable var location: Location
    
    var body: some View {
        Form {
            TextField("Location Name", text: $location.name)
                .font(.title)
                .textInputAutocapitalization(.words)
                .disableAutocorrection(true)
            Text("Current Days: \(location.currentDays)")
            Stepper(value: $location.targetDays, in: 0...365, step: 1) {
                Text("Target Days: \(location.targetDays)")
            }
            Section {
                Button(role: .destructive) {
                } label: {
                    Text("Delete")
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var location = Location(name: "London", targetDays: 120)
    LocationView(location: location)
}
