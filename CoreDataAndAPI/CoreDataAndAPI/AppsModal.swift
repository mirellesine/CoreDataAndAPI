//
//  AppsModal.swift
//  CoreDataAndAPI
//
//  Created by Thayna Rodrigues on 21/08/23.
//

import SwiftUI

// Essa view é acessada ao clicar no + dentro de uma pasta. Lista todos os apps da API e adiciona na pasta quando o usuário seleciona um deles

struct AppsModal: View {

    @ObservedObject var viewModel = ProjectViewModel()
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    let folder: Folder
    
    var body: some View {
        NavigationView {
            List(viewModel.filteredProjects) { project in
                Button(action: {
                    addAppFolder(project: project)
                }) {
                    HStack(alignment: .top) {
                        Image(systemName: "app") // app icon
                        Text("\(project.name)")
                            .foregroundColor(.black)
                    }
                }
                .navigationTitle("All Apps")
            }
            .onAppear(perform: viewModel.fetchProjects)            
            .navigationBarTitle("Apps", displayMode: .inline)
        }
        .searchable(text: $viewModel.searchText)
    }
    
    func addAppFolder(project: Project){
        let app = AppInfo(context: moc)
        app.id = project.id
        app.name = project.name
        app.details = project.description
        
        folder.addToApp_folder(app)
        
        
        try? moc.save()
        dismiss()
    }
}
