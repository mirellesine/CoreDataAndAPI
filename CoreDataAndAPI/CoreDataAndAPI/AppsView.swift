//
//  AppsView.swift
//  nano-test
//
//  Created by Thayna Rodrigues on 21/08/23.
//

import SwiftUI

// Essa view lista todos os apps da API e, ao clicar nos apps, é possível visualizar os detalhes de cada um
struct AppsView: View {
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
}
    
//    struct AppsView_Previews: PreviewProvider {
//        static var previews: some View {
//            AppsView( apps: <#FetchRequest<AppInfo>#>)
//        }
//    }
//}
