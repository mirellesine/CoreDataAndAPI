//
//  CoreDataAndAPIApp.swift
//  CoreDataAndAPI
//
//  Created by Mirelle Sine on 21/08/23.
//

import SwiftUI

@main
struct CoreDataAndAPIApp: App {
    
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
            //core data
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
