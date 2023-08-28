//
//  TabBarView.swift
//  CoreDataAndAPI
//
//  Created by Mirelle Sine on 23/08/23.
//

import SwiftUI

struct TabBarView: View {
    
    @StateObject private var loginViewModel = LoginViewModel()

    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Folders", systemImage: "folder")
                }
                .navigationTitle("Folders")
            
            AppsView()
                .tabItem {
                    Label("Apps", systemImage: "square.grid.2x2.fill")
                }
            
            if loginViewModel.role == "mentor" {
                PostAppView()
                    .tabItem {
                        Label("Publish", systemImage: "app")
                    }
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
