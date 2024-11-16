//
//  StarWarsPlanetDataModel.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import Foundation

// MARK: - SwapiPlanetResults
struct SwapiPlanetResults: Codable {
    let count: Int
    let next: String
    let previous: JSONNull?
    let results: [Planet]
}

// MARK: - Planet
struct Planet: Codable, Identifiable, SWAPISearchResultPresentable {
    let id = UUID()
    let name, rotationPeriod, orbitalPeriod, diameter: String
    let climate, gravity, terrain, surfaceWater: String
    let population: String
    let residents, films: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter, climate, gravity, terrain
        case surfaceWater = "surface_water"
        case population, residents, films, created, edited, url
    }
}
