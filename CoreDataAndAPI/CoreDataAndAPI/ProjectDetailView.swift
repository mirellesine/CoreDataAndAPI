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
            
            AsyncImage(url: project.imgIcon) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.frame(width: 100, height: 100)
            
            Text(project.name).font(.title)
            Text(project.turma).font(.headline)
            Text(project.description)
                .font(.subheadline)
                .padding(.vertical)
            Divider()
            Text(project.bigIdea)
            Text(project.challenge)
            Text(project.essentialQuestion)
            Spacer()
        }
        .navigationBarTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
