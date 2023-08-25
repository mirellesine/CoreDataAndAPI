//
//  ContentView.swift
//  CoreDataAndAPI
//
//  Created by Mirelle Sine on 21/08/23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Folder.name, ascending: true)]
        ) var folders: FetchedResults<Folder>
    
    // state para abrir a modal
    @State private var showingNewFolderModal = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(folders) { folder in
                    NavigationLink {
                        FolderView(folder: folder)
                    } label: {
                        HStack {
                            Image(systemName: "folder")
                                .foregroundColor(.cyan)
                            VStack() {
                                Text(folder.name ?? "Unknown folder")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteFolders)
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
    func deleteFolders(at offsets: IndexSet) {
        for offset in offsets {
            let folder = folders[offset]
            moc.delete(folder)
        }

        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
