//
//  NewFolderModal.swift
//  CoreDataAndAPI
//
//  Created by Thayna Rodrigues on 21/08/23.
//

import SwiftUI

// Essa view cria uma nova pasta
struct NewFolderModal: View {
    
    
    //variavel responsavel por fechar a modal
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    @State private var folderName = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("New Folder", text: $folderName)
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                Spacer()
            }
            .navigationBarTitle("Create New Folder", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                dismiss()
            }, label: {
                Text("Cancel")
            }), trailing: Button(action: {
                let newFolder = Folder(context: moc)
                newFolder.id = UUID()
                newFolder.name = folderName
                
                try? moc.save()
                dismiss()
                
            }, label: {
                Text("Done").bold()
            }))
            .padding()
        }
    }
}

struct NewFolderModal_Previews: PreviewProvider {
    static var previews: some View {
        NewFolderModal()
    }
}
