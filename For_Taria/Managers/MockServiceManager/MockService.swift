//
//  MockService.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/24/25.
//

// Hard-coded data for SwiftUI previews and PlanetFocusView's fallback planet.
struct MockService {
    static let shared = MockService()
    
    static var testPlanet = Planet(
        name: "Earth",
        rotationPeriod: "23.9 hours",
        orbitalPeriod: "365.25 days",
        diameter: "12760 km",
        climate: "temperate",
        gravity: "-9.8m/s",
        terrain: "Continental",
        surfaceWater: "Salt",
        population: "9 billion",
        residents: ["Humans"],
        films: ["Earth", "Earth 2"],
        created: "Long time ago",
        edited: "now",
        url: "www.example.com"
    )
}
