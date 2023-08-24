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
            List(viewModel.filteredProjects) { project in
                Button(action: {
                    //adicionar aqui a ação de clicar no app
                    print("item checked: \(project.name)")
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
}
