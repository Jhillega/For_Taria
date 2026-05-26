//
//  StarWarsSpeciesDataModel.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import Foundation

// MARK: - SwapiSpeciesResults
struct SwapiSpeciesResults: Codable {
    let count: Int
    let next: String?
    let previous: JSONNull?
    let results: [Species]?
}

// MARK: - Species
struct Species: Codable, Identifiable, Sendable {
    let id = UUID()
    let name, classification: String
    let designation: Designation
    let averageHeight, skinColors, hairColors, eyeColors: String
    let averageLifespan: String
    let homeworld: String?
    let language: String
    let people, films: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, classification, designation
        case averageHeight = "average_height"
        case skinColors = "skin_colors"
        case hairColors = "hair_colors"
        case eyeColors = "eye_colors"
        case averageLifespan = "average_lifespan"
        case homeworld, language, people, films, created, edited, url
    }
}

enum Designation: String, Codable {
    case reptilian = "reptilian"
    case sentient = "sentient"
}

