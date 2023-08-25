//
//  DataController.swift
//  HydrationApp
//
//  Created by Rohan on 8/23/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "WaterData") // Tells Core Data that WaterData should be used
    
    init() {
        container.loadPersistentStores { description, error in //Loads Stored Data
            if let error = error {
                print("Core Data Failed To Load: \(error.localizedDescription)")
            }
        }
    }
}
