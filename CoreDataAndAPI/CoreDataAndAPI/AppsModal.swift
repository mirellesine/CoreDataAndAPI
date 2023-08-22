//
//  AppsModal.swift
//  CoreDataAndAPI
//
//  Created by Thayna Rodrigues on 21/08/23.
//

import SwiftUI

// Essa view é acessada ao clicar no + dentro de uma pasta. Lista todos os apps da API e adiciona na pasta quando o usuário seleciona um deles
struct AppsModal: View {
    let items = ["Item 1", "Item 2"]
    let appIcon = "apps.iphone"
    let appDescription = "Description of the app"
    
    var body: some View {
        NavigationView {
            VStack {
                List(items, id: \.self) { item in
                    Button(action: {
                        //Ação de clicar no app
                        print("item checked: \(item)")
                    }) {
                        HStack(alignment: .top) {
                            Image(systemName: appIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding(5)
                            VStack(alignment: .leading) {
                                Text(item)
                                    .font(.headline)
                                Text(appDescription)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Apps", displayMode: .inline)
        }
    }
}

struct AppsModal_Previews: PreviewProvider {
    static var previews: some View {
        AppsModal()
    }
}
