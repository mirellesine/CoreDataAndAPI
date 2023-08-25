//
//  ProjectDetailView.swift
//  CoreDataAndAPI
//
//  Created by Thayna Rodrigues on 24/08/23.
//

import SwiftUI

struct ProjectDetailView: View {
    let project: Project
    
    var body: some View {
        VStack {
            // ícone do projeto
            AsyncImage(url: project.imgIcon) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.frame(width: 100, height: 100)
            
            // nome, turma e descrição
            VStack {
                ProjectInfo(project: project)
            }
            
            Divider()
            
            // info do CBL
            VStack {
                CBLInfo(project: project)
            }
            
            // link app store
            
            VStack {
                AppStoreButton(project: project)
            }
            
            Spacer()
        }
        .navigationBarTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct ProjectInfo: View {
    let project: Project
    var body: some View {
        VStack {
            Text(project.name).font(.title)
            Text(project.turma).font(.headline)
            Text(project.description)
                .font(.subheadline)
                .padding(.vertical)
        }
    }
}

struct CBLInfo: View {
    let project: Project
    
    var body: some View {
        VStack {
            Text(project.bigIdea)
            Text(project.challenge)
            Text(project.essentialQuestion)
        }
    }
}

struct AppStoreButton: View {
    let project: Project
    
    var body: some View {
        VStack {
            if let url = URL(string: project.link) {
                Link(destination: url, label: {
                    Image("AppStoreBadge")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                })
            } else {
                Text("Invalid Link")
            }
        }
    }
}
