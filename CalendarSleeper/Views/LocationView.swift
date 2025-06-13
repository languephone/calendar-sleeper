//
//  LocationView.swift
//  CalendarSleeper
//
//  Created by Shapiro, Daniel on 6/13/25.
//

import SwiftUI

struct LocationView: View {
    @ObservedObject var location: Location
    let range = 1...50
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("", text: $location.name)
                .font(.largeTitle)
                .textInputAutocapitalization(.words)
                .disableAutocorrection(true)
                .multilineTextAlignment(.center)
            HStack {
                Text("Current Days: \(location.currentDays)")
                Spacer()
            }
            Stepper(
                value: Binding(
                    get: { location.targetDays ?? 0 }, // default if nil
                    set: { location.targetDays = $0 }
                ),
                in: 0...365,
                step: 1
            ) {
                Text("Target Days: \(location.targetDays ?? 0)")
            }
            ColorPicker("Color", selection: $location.primaryColor, supportsOpacity: false)
        }
        .frame(maxWidth: 300)
    }
}

#Preview {
    @Previewable @StateObject var location = Location(name: "London", primaryColor: .blue, targetDays: 120, currentDays: 0)
    LocationView(location: location)
}
