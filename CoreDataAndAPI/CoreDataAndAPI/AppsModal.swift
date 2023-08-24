//
//  AppsModal.swift
//  CoreDataAndAPI
//
//  Created by Thayna Rodrigues on 21/08/23.
//

import SwiftUI

// Essa view é acessada ao clicar no + dentro de uma pasta. Lista todos os apps da API e adiciona na pasta quando o usuário seleciona um deles
struct AppsModal: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest var apps: FetchedResults<AppInfo>
    
    @State private var showingAddScreen = false
    
    let items = ["Item 1", "Item 2"]
    let appIcon = "apps.iphone"
    let appDescription = "Description of the app"
    
    var body: some View {
        NavigationView {
            VStack {
                List{
                    ForEach(apps) { app in
                        NavigationLink {
                            DetailView(app: app)
                        } label: {
                            HStack(alignment: .top) {
                                Image(systemName: appIcon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .padding(5)
                                VStack(alignment: .leading) {
                                    Text(app.name ?? "Name's app")
                                        .font(.headline)
                                    Text(appDescription)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("All Apps")
            }
        }
    }
    
    struct AppsModal_Previews: PreviewProvider {
        static var previews: some View {
            AppsModal( apps: <#FetchRequest<AppInfo>#>)
        }
    }
}
