//
//  AppsViewModel.swift
//  CoreDataAndAPI
//
//  Created by Thayna Rodrigues on 24/08/23.
//

import Foundation
import Combine
import Alamofire

// VIEW MODEL DA LISTA DE PROJETOS
class ProjectViewModel: ObservableObject {
    @Published var projects: [Project] = [] // lista de projetos/apps
    @Published var searchText: String = ""
    
    private var projectFetchTask: AnyCancellable? // task de busca de projetos
    
    var filteredProjects: [Project] {
        guard !searchText.isEmpty else { return projects }
        
        return projects.filter { project in
            project.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    func fetchProjects() {
        
        // verifica a URL
        guard let url = URL(string: "https://api-project-academy-9cf71ea0cac6.herokuapp.com/project") else { return }
        
        // inicia o fetch com uma urlsession
        projectFetchTask = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data) // mapeia e extrai os dados
            .decode(type: [Project].self, decoder: JSONDecoder()) // faz a decodificação do JSON
            .replaceError(with: []) // lida com erros
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] decodedProjects in
                self?.projects = decodedProjects // atualiza a lista de projetos
            })
    }
    
    func postProjects() {
        let login = Login(email: "test@test.test", password: "testPassword")

        AF.request("https://httpbin.org/post",
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default).response { response in
            debugPrint(response)
        }
    }
}

struct Login: Encodable {
    let email: String
    let password: String
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
