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
                if let appIconURL = URL(string: app.appIcon ?? "") {
                    AsyncImage(url: appIconURL) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }.frame(width: 100, height: 100)
                } else {
                    Text("Invalid image")
                }
            }
            
            // nome, turma e descrição
            VStack {
                ProjectInfoDetail(app: app)
            }
            
            Divider().padding()
            
            // info do CBL
            VStack(alignment: .leading) {
                CBLInfoDetail(app: app)
            }
            Spacer()
            
        }.padding()
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

struct ProjectInfoDetail: View {
    let app: AppInfo

    var body: some View {
        VStack {
            Text(app.name ?? "Not found")
                .font(.title)
            Text(app.turma ?? "Not found")
                .font(.headline)
                .padding(.bottom)
            Text(app.details ?? "Not found")
                .font(.subheadline)
        }
    }
}

struct CBLInfoDetail: View {
    let app: AppInfo

    var body: some View {
        VStack {
            Text("Big idea: ")
                .bold()
                .font(.callout)
            + Text(app.bigIdea ?? "Not found")
                .font(.callout)
        }.padding(.bottom, 2)
        
        VStack {
            Text("Challenge: ")
                .bold()
                .font(.callout)
            + Text(app.challenge ?? "Not found")
                .font(.callout)
        }.padding(.bottom, 2)
        
        VStack {
            Text("Essential Question: ")
                .bold()
                .font(.callout)
            + Text(app.essentialQuestion ?? "Not found")
                .font(.callout)
        }.padding(.bottom, 2)
    }
}
