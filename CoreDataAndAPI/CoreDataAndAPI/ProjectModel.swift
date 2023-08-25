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
