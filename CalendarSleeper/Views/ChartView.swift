//
//  DonutChartView.swift
//  CalendarSleeper
//
//  Created by Daniel Shapiro on 8/20/25.
//

import SwiftUI
import SwiftData
import Charts

struct DonutChartView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \Location.createDate) var locations: [Location]

    var body: some View {
        Chart(locations) { location in
            SectorMark(
                angle: .value("current days", location.currentDays),
                innerRadius: .ratio(0.618),
                angularInset: 1.5
            )
            .cornerRadius(5)
            .foregroundStyle(by: .value("Name", location.name))
        }
        .padding()
    }
}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(
            for: Location.self,
            configurations: config
        )
        let example1 = Location(name: "Madrid", targetDays: 50)
        let example2 = Location(name: "Barcelona", targetDays: 100)
        container.mainContext.insert(example1)
        container.mainContext.insert(example2)
        for i in 0...30 {
            container.mainContext.insert(Day(date: .now, location: example1))
            container.mainContext.insert(Day(date: .now, location: example2))
        }
        for i in 0...20 {
            container.mainContext.insert(Day(date: .now, location: example2))
        }
        return DonutChartView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
