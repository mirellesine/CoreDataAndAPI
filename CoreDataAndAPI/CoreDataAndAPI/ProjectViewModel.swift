//
//  AppsViewModel.swift
//  CoreDataAndAPI
//
//  Created by Thayna Rodrigues on 24/08/23.
//

import Foundation
import Combine

// VIEW MODEL DA LISTA DE PROJETOS
class ProjectViewModel: ObservableObject {
    @Published var projects: [Project] = []

        private var cancellables: Set<AnyCancellable> = []

        func fetchProjects() {
            guard let url = URL(string: "https://api-project-academy-9cf71ea0cac6.herokuapp.com/project") else { return }

            URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: [Project].self, decoder: JSONDecoder())
                .replaceError(with: [])
                .receive(on: DispatchQueue.main)
                .assign(to: \.projects, on: self)
                .store(in: &cancellables)
        }
}


/*
 
 
 
 ARRUMA AS URLs (?):
 
 DispatchQueue.main.async {
 self.projects = decodedProjects.map { project in
 var urlFix = project
 urlFix.imgIcon = URL(string: project.imgIcon.absoluteString.replacingOccurrences(of: "\\/", with: "/"))!
 return urlFix
 }
 }
 */
