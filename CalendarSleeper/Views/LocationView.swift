//
//  LocationView.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 6/13/25.
//

import SwiftUI

struct LocationView: View {
    @Bindable var location: Location
    @State var tempTargetDays: Double
    
    var body: some View {
        Form {
            // Edit Location Name
            TextField("Location Name", text: $location.name)
                .font(.title)
                .textInputAutocapitalization(.words)
                .disableAutocorrection(true)
            
            // Display accumulated days
            Text("Current Days: \(location.currentDays)")
            
            // Edit Target Days via Slider & Stepper
            VStack(alignment: .leading) {
                // Stepper and Slider both work on the tempTargetDays variable,
                // then move changes to the location.targetDays attribute when
                // The onEditingChanged value updates.
                Stepper(value: $tempTargetDays,
                        in: 0...365,
                        label: { Text("Target Days: \(Int(tempTargetDays))") },
                        onEditingChanged: { _ in location.targetDays = Int(tempTargetDays) }
                )
                Slider(value: $tempTargetDays,
                       in: 0...365,
                       label: {Text("Temp Days")},
                       onEditingChanged: { _ in  location.targetDays = Int(tempTargetDays) }
                )
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
    LocationView(location: location, tempTargetDays: Double(location.targetDays))
}
