//
//  ContentView.swift
//  CoreDataAndAPI
//
//  Created by Mirelle Sine on 21/08/23.
//

import SwiftUI

struct Folder: Identifiable {
    var id = UUID()
    var name: String
}

struct ContentView: View {
    @State private var showingNewFolderModal = false
    
    let folders: [Folder] = [
            Folder(name: "Folder 1"),
            Folder(name: "Folder 2"),
            Folder(name: "Folder 3"),
            Folder(name: "Folder 4")
        ]
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(folders) { folder in
                    NavigationLink {
                        FolderView()
                    } label: {
                        HStack {
                            Image(systemName: "folder")
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
                .navigationTitle("Folders")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingNewFolderModal.toggle()
                        } label: {
                            Label("Add Folder", systemImage: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingNewFolderModal) {
                    NewFolderModal()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
