//
//  StarWarsStarshipDataModel.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import Foundation
// MARK: - SwapiStarshipResults
struct SwapiStarshipResults: Codable {
    let count: Int
    let next: String?
    let previous: JSONNull?
    let results: [Starship]?
}

// MARK: - Starship
struct Starship: SWAPIRetrievable {
    var id = UUID()
    let name, model, manufacturer, costInCredits: String?
    let length, maxAtmospheringSpeed, crew, passengers: String?
    let cargoCapacity, consumables, hyperdriveRating, mglt: String?
    let starshipClass: String?
    let pilots, films: [String]?
    let created, edited: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case name, model, manufacturer
        case costInCredits = "cost_in_credits"
        case length
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case crew, passengers
        case cargoCapacity = "cargo_capacity"
        case consumables
        case hyperdriveRating = "hyperdrive_rating"
        // SWAPI returns "MGLT" in all-caps; the property stays lowercase by convention.
        case mglt = "MGLT"
        case starshipClass = "starship_class"
        case pilots, films, created, edited, url
    }
}

