//
//  DataController.swift
//  CoreDataAndAPI
//
//  Created by Thayna Rodrigues on 22/08/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    // Cria uma instância de NSPersistentContainer com o nome "CoreDataAndAPI"
    let container = NSPersistentContainer(name: "CoreDataAndAPI")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
