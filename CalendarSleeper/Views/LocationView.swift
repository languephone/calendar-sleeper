//
//  LocationView.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 6/13/25.
//

import SwiftUI

struct LocationView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Bindable var location: Location
    @State var tempTargetDays: Double
    @FocusState private var locationNameInFocus: Bool
    
    var body: some View {
        Form {
            // Edit Location Name
            TextField("Location Name", text: $location.name)
                .font(.title)
                .textInputAutocapitalization(.words)
                .disableAutocorrection(true)
                .focused($locationNameInFocus)

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
                        onEditingChanged: { _ in
                            location.targetDays = Int(tempTargetDays)
                            locationNameInFocus = false
                        }
                )
                Slider(value: $tempTargetDays,
                       in: 0...365,
                       label: {Text("Temp Days")},
                       onEditingChanged: { _ in
                           location.targetDays = Int(tempTargetDays)
                           locationNameInFocus = false
                       }
                )
            }
            Section {
                Button("Delete", role: .destructive) {
                    context.delete(location)
                    dismiss()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.locationNameInFocus = true
            }
        }
    }
}

#Preview {
    @Previewable @State var location = Location(name: "London", targetDays: 120)
    LocationView(location: location, tempTargetDays: Double(location.targetDays))
}
