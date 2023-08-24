//
//  AppsViewModel.swift
//  CoreDataAndAPI
//
//  Created by Thayna Rodrigues on 24/08/23.
//

import Foundation

// VIEW MODEL DA LISTA DE PROJETOS
class ProjectViewModel: ObservableObject {
    @Published var projects: [Project] = []
    
    // função para fazer o fetch dos apps na API
    func fetchProjects() {
        guard let url = URL(string: "https://api-project-academy-9cf71ea0cac6.herokuapp.com/project") else { return }
        
        // criação da sessão
        URLSession.shared.dataTask(with: url) { data, response, error in
            // guard let para verificar se tem algum dado a ser recebido da API
            guard let data = data, error == nil else { return }
            
            // criação de uma instancia do decodificador
            let decoder = JSONDecoder()
            
            // decodificação do JSON
            if let decodedProjects = try? decoder.decode([Project].self, from: data) {
                // atualiza a view de projetos
                DispatchQueue.main.async {
                    self.projects = decodedProjects
                }
            }
        }.resume() // inicia o fetch da API
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
