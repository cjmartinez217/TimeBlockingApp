//
//  TimeBlockingAppApp.swift
//  TimeBlockingApp
//
//  Created by Christian Martinez on 10/11/24.
//

import SwiftUI

@main
struct TimeBlockingAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
