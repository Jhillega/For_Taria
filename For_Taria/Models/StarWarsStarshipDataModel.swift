//
//  StarWarsStarshipDataModel.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import Foundation

class StarWarsStarshipDataModel: ObservableObject {
    @Published var currentFetchedStarships = [Planet]()
    
    let baseStarshipURL = "https://swapi.dev/api/starships/"
    
    func fetchStarshipsFromAGalaxyFarFarAway() async -> [Starship] {
        var starshipsToReturn: [Starship] = []
        
        guard let url = URL(string: baseStarshipURL) else {
            fatalError("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return []
            }
            
            if let starships = self.parseStarshipJson(data) {
                starshipsToReturn = starships
            }
        } catch {
            return []
        }
        return starshipsToReturn
    }
    
    func parseStarshipJson(_ starshipsData: Data) -> [Starship]? {
        let decoder = JSONDecoder()
        do {
            let decodedStarships = try decoder.decode(SwapiStarshipResults.self, from: starshipsData)
            let starshipsToReturn = decodedStarships.results
            return starshipsToReturn
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
}

// MARK: - SwapiStarshipResults
struct SwapiStarshipResults: Codable {
    let count: Int
    let next: String
    let previous: JSONNull?
    let results: [Starship]
}

// MARK: - Starship
struct Starship: Codable, Identifiable {
    var id = UUID()
    let name, model, manufacturer, costInCredits: String
    let length, maxAtmospheringSpeed, crew, passengers: String
    let cargoCapacity, consumables, hyperdriveRating, mglt: String
    let starshipClass: String
    let pilots, films: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, model, manufacturer
        case costInCredits = "cost_in_credits"
        case length
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case crew, passengers
        case cargoCapacity = "cargo_capacity"
        case consumables
        case hyperdriveRating = "hyperdrive_rating"
        case mglt = "MGLT"
        case starshipClass = "starship_class"
        case pilots, films, created, edited, url
    }
}

