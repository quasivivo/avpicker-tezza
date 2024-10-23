//
//  avpickerApp.swift
//  avpicker
//
//  Created by Will Hannah on 10/22/24.
//

import SwiftData
import SwiftUI

@main
struct avpickerApp: App {
    @StateObject var appState = AppState()

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ImportedAsset.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
        .environmentObject(appState)
    }
}
