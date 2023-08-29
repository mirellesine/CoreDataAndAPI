//
//  FolderView.swift
//  CoreDataAndAPI
//
//  Created by Mirelle Sine on 21/08/23.
//

import SwiftUI
import CoreData


//essa view apresenta tudo que tem dentro da pasta
struct FolderView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name),
        SortDescriptor(\.id)
    ]) var folders: FetchedResults<Folder>
    
    @State private var showingAppsModal = false
    
    let folder: Folder
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(fetchApps(for: folder)) { app in
                    NavigationLink {
                        DetailView(app: app)
                    } label: {
                        HStack {
                            if let appIconURL = URL(string: app.appIcon ?? "") {
                                AsyncImage(url: appIconURL) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }.frame(width: 30, height: 30)
                            } else {
                                Text("Invalid image")
                            }
                            VStack(alignment: .leading) {
                                Text(app.name ?? "Unknown app")
                            }
                        }
                    }
                }
                .onDelete(perform: deleteApp)
            }
            .navigationTitle(folder.name ?? "")
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
                AppsModal(folder: folder)
            }
        }
    }
    
    func deleteApp(at offsets: IndexSet) {
        for index in offsets {
            let appToDelete = fetchApps(for: folder)[index]
            moc.delete(appToDelete)
        }
        
        do {
            try moc.save()
        } catch {
            fatalError("Error deleting app: \(error)")
        }
    }

    
    func fetchApps(for folder: Folder) -> [AppInfo] {
        let fetchRequest: NSFetchRequest<AppInfo> = AppInfo.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "ANY app_folder == %@", folder)

        do {
            let apps = try moc.fetch(fetchRequest)
            return apps
        } catch {
            fatalError("Error fetching apps: \(error)")
        }
    }
}
