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
    let description: String
    let link: String
    var imgIcon: URL
}
