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
    let next: String?
    let previous: JSONNull?
    let results: [Planet]?
}

// MARK: - Planet
struct Planet: SWAPIRetrievable {
    let id = UUID()
    let name, rotationPeriod, orbitalPeriod, diameter: String?
    let climate, gravity, terrain, surfaceWater: String?
    let population: String?
    let residents, films: [String]?
    let created, edited: String?
    let url: String?

    enum CodingKeys: String, CodingKey, CaseIterable, Identifiable {
        var id: String { rawValue }
        
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter, climate, gravity, terrain
        case surfaceWater = "surface_water"
        case population, residents, films, created, edited, url
        
        var displayablePropertyName: String {
            switch self {
            case .name:
                "Name"
            case .rotationPeriod:
                "Day Length"
            case .orbitalPeriod:
                "Year Length"
            case .diameter:
                "Diameter"
            case .climate:
                "Climate"
            case .gravity:
                "Gravity"
            case .terrain:
                "Terrain"
            case .surfaceWater:
                "Surface Water"
            case .population:
                "Population"
            case .residents:
                "Resident"
            case .films:
                "Seen In"
            case .created:
                "Created"
            case .edited:
                "Edited"
            case .url:
                "URL"
            }
        }
    }
    
    static var displayablePropertyNames: [CodingKeys] {
        var names: [CodingKeys] = []
        CodingKeys.allCases.forEach { names.append($0) }
        return names
    }
    
    
    public func dataForProperty(_ property: CodingKeys) -> String {
        switch property {
        case .name:
            self.name ?? "unknown"
        case .rotationPeriod:
            self.rotationPeriod ?? "unknown"
        case .orbitalPeriod:
            self.orbitalPeriod ?? "unknown"
        case .diameter:
            self.diameter ?? "unknown"
        case .climate:
            self.climate ?? "unknown"
        case .gravity:
            self.gravity ?? "unknown"
        case .terrain:
            self.terrain ?? "unknown"
        case .surfaceWater:
            self.surfaceWater ?? "unknown"
        case .population:
            self.population ?? "unknown"
        case .residents:
            self.residents?.joined(separator: ", ") ?? "unknown"
        case .films:
            self.films?.joined(separator: ", ") ?? "unknown"
        case .created:
            self.created ?? "unknown"
        case .edited:
            self.edited ?? "unknown"
        case .url:
            self.url ?? "unknown"
        }
    }
}
