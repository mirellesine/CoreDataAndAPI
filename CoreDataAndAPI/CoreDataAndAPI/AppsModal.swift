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
    
    var body: some View {
        NavigationView {
            List(viewModel.projects) { project in
                Button(action: {
                    //adicionar aqui a ação de clicar no app
                    print("item checked: \(project.name)")
                }) {
                    HStack(alignment: .top) {
                        Image(systemName: "app") // app icon
                        Text("\(project.name)")
                            .foregroundColor(.black)
                    }
                    .onDelete(perform: deleteAppInfos)
                }
                .navigationTitle("All Apps")
            }
            .onAppear(perform: viewModel.fetchProjects)            
            .navigationBarTitle("Apps", displayMode: .inline)
        }
    }
    
    func deleteAppInfos(at offsets: IndexSet) {
        for offset in offsets {
            let app = apps[offset]
            moc.delete(app)
        }
        
        try? moc.save()
    }
}
