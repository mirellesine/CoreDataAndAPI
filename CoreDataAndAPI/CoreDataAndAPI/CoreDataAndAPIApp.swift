//
//  CoreDataAndAPIApp.swift
//  CoreDataAndAPI
//
//  Created by Mirelle Sine on 21/08/23.
//

import SwiftUI

@main
struct CoreDataAndAPIApp: App {
    
    // Cria uma instância de DataController como uma propriedade com estado
    @StateObject private var dataController = DataController()
    @StateObject private var loginViewModel = LoginModel()

    var body: some Scene {
        WindowGroup {
            if loginViewModel.loginView {
                LoginView()
            } else{
                TabBarView()
                //configura o ambiente para fornecer o contexto de gerenciamento do core data da instancia de DataController
                .environment(\.managedObjectContext, dataController.container.viewContext)
            }
        }
    }
}
