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
        ScrollView {
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
                
                Divider().padding()
                
                // info do CBL
                VStack(alignment: .leading) {
                    CBLInfo(project: project)
                }
                
                Divider().padding()
                
                // link app store
                VStack {
                    AppStoreButton(project: project)
                }
                Spacer()
                
            }.padding()
                .navigationBarTitle("")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct ProjectInfo: View {
    let project: Project
    var body: some View {
        VStack {
            Text(project.name)
                .font(.title)
            Text(project.turma)
                .font(.headline)
                .padding(.bottom)
            Text(project.description)
                .font(.subheadline)
        }
    }
}

struct CBLInfo: View {
    let project: Project
    
    var body: some View {
        VStack {
            Text("Big idea: ")
                .bold()
                .font(.callout)
            + Text("\(project.bigIdea)")
                .font(.callout)
        }.padding(.bottom, 2)
        
        VStack {
            Text("Challenge: ")
                .bold()
                .font(.callout)
            + Text("\(project.challenge)")
                .font(.callout)
        }.padding(.bottom, 2)
        
        VStack {
            Text("Essential Question: ")
                .bold()
                .font(.callout)
            + Text("\(project.essentialQuestion)")
                .font(.callout)
        }.padding(.bottom, 2)
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
                Text("")
            }
        }
    }
}
