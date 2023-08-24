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
        NavigationView {
            List(viewModel.projects) { project in
                NavigationLink(destination: ProjectDetailView(project: project)) {
                    HStack(alignment: .top) {
                        Image(systemName: "app")
                            .foregroundColor(.cyan)
                        VStack() {
                            Text("\(project.name)")
                        }
                    }
                }
            }
            .navigationBarTitle("All Apps")
            .onAppear(perform: viewModel.fetchProjects)
        }
        
    }
}


struct AppsView_Previews: PreviewProvider {
    static var previews: some View {
        AppsView()
    }
}
