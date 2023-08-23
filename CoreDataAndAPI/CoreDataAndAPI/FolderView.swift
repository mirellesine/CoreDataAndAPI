//
//  FolderView.swift
//  CoreDataAndAPI
//
//  Created by Mirelle Sine on 21/08/23.
//

import SwiftUI

//elementos que o app pode ter
struct Application: Identifiable {
    var id = UUID()
    var name: String
}

//essa view apresenta tudo que tem dentro da pasta
struct FolderView: View {
    @State private var showingAppsModal = false
    
    let apps: [Application] = [
        Application(name: "App 1"),
        Application(name: "App 2"),
        Application(name: "App 3"),
        Application(name: "App 4")
    ]
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(apps) { folder in
                    NavigationLink {
                        DetailView(apps: "app")
                    } label: {
                        HStack {
                            Image(systemName: "app")
                                .foregroundColor(.cyan)
                                .font(.title)
                            VStack(alignment: .leading) {
                                Text(folder.name)
                                    .font(.headline)
                                
                                Text("descricao")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Apps on this Folder")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAppsModal.toggle()
                    } label: {
                        Label("Add Apps", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAppsModal) {
                AppsModal()
            }
        }
    }
    
    struct FolderView_Previews: PreviewProvider {
        static var previews: some View {
            FolderView()
        }
    }
}
