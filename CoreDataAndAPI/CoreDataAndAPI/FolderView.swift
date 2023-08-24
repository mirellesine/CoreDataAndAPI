//
//  FolderView.swift
//  CoreDataAndAPI
//
//  Created by Mirelle Sine on 21/08/23.
//

import SwiftUI

//essa view apresenta tudo que tem dentro da pasta
struct FolderView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name),
        SortDescriptor(\.id)
    ]) var folders: FetchedResults<Folder>
    
    @State private var showingAppsModal = false
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(folders) { folder in
                    NavigationLink {
                        //precisa do relacionamento
                        //AppsModal(apps: apps)
                    } label: {
                        HStack {
                            Image(systemName: "app")
                                .foregroundColor(.cyan)
                                .font(.title)
                            VStack(alignment: .leading) {
                                Text(folder.name ?? "Unknown folder")
                                    .font(.headline)
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
