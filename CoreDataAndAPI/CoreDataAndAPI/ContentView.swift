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
    let folders: [Folder] = [
            Folder(name: "Folder 1"),
            Folder(name: "Folder 2"),
            Folder(name: "Folder 3"),
            Folder(name: "Folder 4")
        ]
    var body: some View {
        
        NavigationView {
            List {
                ForEach(folders) { folder in
                    NavigationLink {
                        
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
                            //ACAO DO +
                        } label: {
                            Label("Add Folder", systemImage: "plus")
                        }
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
