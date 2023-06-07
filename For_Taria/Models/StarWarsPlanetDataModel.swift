//
//  StarWarsPlanetDataModel.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import Foundation
import SwiftUI

class StarWarsPlanetsDataModel: ObservableObject {
    @Published var currentFetchedPlanets: [Planet]?
    
    let basePlanetURL = "https://swapi.dev/api/planets/"
    
    @MainActor
    func executePlanetCall() async {
        await fetchPlanetsFromAGalaxyFarFarAway()
    }
    
    @MainActor
    func fetchPlanetsFromAGalaxyFarFarAway() async {
        guard let url = URL(string: basePlanetURL) else {
            fatalError("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return
            }
            if let planets = self.parsePlanetJSON(data) {
                currentFetchedPlanets = planets
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            return
        }
    }
    
    func parsePlanetJSON(_ planetsData: Data) -> [Planet]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(SwapiPlanetResults.self, from: planetsData)
            let planetsToReturn = decodedData.results
            return planetsToReturn
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
}

// MARK: - SwapiPlanetResults
struct SwapiPlanetResults: Codable {
    let count: Int
    let next: String
    let previous: JSONNull?
    let results: [Planet]
}

// MARK: - Planet
struct Planet: Codable, Identifiable {
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
