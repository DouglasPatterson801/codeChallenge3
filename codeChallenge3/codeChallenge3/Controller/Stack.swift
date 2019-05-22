//
//  Stack.swift
//  codeChallenge3
//
//  Created by Douglas Patterson on 5/21/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import Foundation
import CoreData

enum Stack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Movie")
        container.loadPersistentStores(){ (storeDescription, error) in
            print(storeDescription)
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
}
