//
//  DetailView.swift
//  CoreDataAndAPI
//
//  Created by Mirelle Sine on 21/08/23.
//

import SwiftUI

struct DetailView: View {
    let app: AppInfo
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image("Kids")
                    .resizable()
                    .scaledToFit()
            }
            
            Text(app.name ?? "")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(app.details ?? "")
                .font(.callout)
                .padding()
            
            
        }
        .navigationTitle(app.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete App ?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteAppInfo)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this app", systemImage: "trash")
            }
        }
    }
    func deleteAppInfo() {
        moc.delete(app)

        try? moc.save()
        dismiss()
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            DetailView(apps: "app")
//        }
//    }
//}
