//
//  PersistanceController.swift
//  RecipeApp
//
//  Created by shubh on 14/10/26.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // In-memory store for SwiftUI previews and tests.
    static let preview = PersistenceController(inMemory: true)

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        // Must match your .xcdatamodeld file name exactly (Model.xcdatamodeld)
        container = NSPersistentContainer(name: "Model")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        // Only matters if you add the uniqueness constraint on `id`
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}
