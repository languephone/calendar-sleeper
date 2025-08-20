//
//  NewLocationView.swift
//  CalendarSleeper
//
//  Created by Daniel Shapiro on 8/19/25.
//

import SwiftUI
import SwiftData

struct NewLocationView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @State var tempName: String
    @State var tempTargetDays: Double = 0
    
    var body: some View {
        Form {
            // Edit Location Name
            TextField("Location Name", text: $tempName)
                .font(.title)
                .textInputAutocapitalization(.words)
                .disableAutocorrection(true)
            
            // Edit Target Days via Slider & Stepper
            VStack(alignment: .leading) {
                // Stepper and Slider both work on the tempTargetDays variable,
                // then move changes to the location.targetDays attribute when
                // The onEditingChanged value updates.
                Stepper(value: $tempTargetDays,
                        in: 0...365,
                        label: { Text("Target Days: \(Int(tempTargetDays))") }
                )
                Slider(value: $tempTargetDays,
                       in: 0...365,
                       label: {Text("Temp Days")},
                )
            }
            Section {
                Button("Save") {
                    if validLocation(tempName) {
                        print("Adding new location")
                        let newLocation = Location(name: tempName, targetDays: Int(tempTargetDays))
                        context.insert(newLocation)
                        dismiss()
                    }
                }
                .disabled(validLocation(tempName) ? false : true)
            }
            Section {
                Button("Discard Changes", role: .destructive) {
                    dismiss()
                }
            }
        }
    }

    func validLocation(_ name: String) -> Bool {
        if name.count > 0 {
            return true
        }
        return false
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(
            for: Location.self,
            configurations: config
        )
        return NewLocationView(tempName: "Location 3")
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
