//
//  AppsView.swift
//  CoreDataAndAPI
//
//  Created by Thayna Rodrigues on 21/08/23.
//

import SwiftUI

// Essa view lista todos os apps da API e, ao clicar nos apps, é possível visualizar os detalhes de cada um
struct AppsView: View {
    
    
    let appIcon = "apps.iphone"
    @ObservedObject var viewModel = ProjectViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                List(viewModel.filteredProjects) { project in
                    NavigationLink(destination: ProjectDetailView(project: project)) {
                        HStack {
                            AsyncImage(url: project.imgIcon) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }.frame(width: 30, height: 30)
                            .padding(5)
                            Text(project.name)
                        }
                    }
                }
                .navigationBarTitle("All Apps")
                .onAppear(perform: viewModel.fetchProjects)
            }
        }
        .searchable(text: $viewModel.searchText)
    }
}
    
    struct AppsView_Previews: PreviewProvider {
        static var previews: some View {
            AppsView()
        }
    }

