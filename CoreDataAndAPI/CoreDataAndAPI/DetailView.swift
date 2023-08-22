//
//  DetailView.swift
//  CoreDataAndAPI
//
//  Created by Mirelle Sine on 21/08/23.
//

import SwiftUI

struct DetailView: View {
    let apps: String
    
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image("Kids")
                    .resizable()
                    .scaledToFit()
            }
            
            Text("Name of the app")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text("Description")
                .font(.callout)
                .padding()
            
            
        }
        .navigationTitle("Name of the app")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete App ?", isPresented: $showingDeleteAlert) {
            //Button("Delete", role: .destructive, action: deleteapps)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(apps: "app")
        }
    }
}
