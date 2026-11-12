//
//  StarWarsVehicleDataModel.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import Foundation

// MARK: - Swapi Results
struct SwapiVehicleResults: Codable {
    let count: Int
    let next: String?
    let previous: JSONNull?
    let results: [Vehicle]?
}

// MARK: - Vehicle
struct Vehicle: SWAPIRetrievable {
    let id = UUID()
    let name, model, manufacturer, costInCredits: String?
    let length, maxAtmospheringSpeed, crew, passengers: String?
    let cargoCapacity, consumables, vehicleClass: String?
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
        case vehicleClass = "vehicle_class"
        case pilots, films, created, edited, url
    }
}
