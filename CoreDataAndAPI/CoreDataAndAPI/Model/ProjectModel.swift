//
//  ProjectModel.swift
//  CoreDataAndAPI
//
//  Created by Thayna Rodrigues on 24/08/23.
//

import Foundation

struct Project: Codable, Identifiable {
    let id: UUID
    let name: String
    let turma: String
    let description: String
    let bigIdea: String
    let challenge: String
    let essentialQuestion: String
    let link: String
    var imgIcon: URL
    var imgScreenshot: URL
}


struct ProjectPost: Encodable, Identifiable {
    let id: UUID
    var name: String
    var turma: String
    var description: String
    var bigIdea: String
    var challenge: String
    var essentialQuestion: String
    var link: String
    var imgIcon: Data?
    var imgScreenshot: Data?
    var ativo:String = "true"
}
