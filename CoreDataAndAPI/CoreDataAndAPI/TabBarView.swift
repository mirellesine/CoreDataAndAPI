//
//  TabBarView.swift
//  CoreDataAndAPI
//
//  Created by Mirelle Sine on 23/08/23.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Folders", systemImage: "folder")
                }
            
            AppsView()
                .tabItem {
                    Label("Apps", systemImage: "square.grid.2x2.fill")
                }
            
            PostAppView()
                .tabItem {
                    Label("Publish", systemImage: "plus.app.fill")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
