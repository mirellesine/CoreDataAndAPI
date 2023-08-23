//
//  ContentView.swift
//  CoreDataAndAPI
//
//  Created by Mirelle Sine on 21/08/23.
//

import SwiftUI

//struct Folder: Identifiable {
//    var id = UUID()
//    var name: String
//}

struct ContentView: View {
    let folder: Folder
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name)
    ]) var folders: FetchedResults<Folder>
    
    // state para abrir a modal
    @State private var showingNewFolderModal = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(folders) { folder in
                    NavigationLink {
                        FolderView()
                    } label: {
                        HStack {
                            Image(systemName: "folder")
                                .foregroundColor(.cyan)
                                    .font(.title)
                            VStack(alignment: .leading) {
                                //Text(book)
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
