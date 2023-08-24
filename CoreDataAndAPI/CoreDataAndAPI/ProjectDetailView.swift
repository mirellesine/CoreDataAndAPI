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
        VStack(alignment: .leading) {
            Text(project.description).padding()
            
            Text("\(project.link)").padding()
                .foregroundColor(.cyan)
            Spacer()
        }
        .padding()
        .navigationBarTitle("\(project.name)")
    }
}
