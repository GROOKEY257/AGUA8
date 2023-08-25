//
//  HydrationAppApp.swift
//  HydrationApp
//
//  Created by Rohan on 8/20/23.
//

import SwiftUI

@main
struct HydrationAppApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext) // Creates one Core Data store for all views to use
        }
    }
}
