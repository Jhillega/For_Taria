//
//  StarWarsVehicleDataModel.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import Foundation

// MARK: - SwapiVehicleResults

class StarWarsVehicleDataModel: ObservableObject {
    @Published var currentFetchedVehicle = [Vehicle]()
    
    let baseVehicleURL = "https://swapi.dev/api/vehicles/"
    
    func fetchVehiclesFromAGalaxyFarFarAway() async -> [Vehicle]? {
        var vehiclesToReturn = [Vehicle]()
        
        guard let url = URL(string: baseVehicleURL) else {
            fatalError("URL problems")
        }
        
        let urlrequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlrequest)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return nil
            }
            
            if let vehicles = self.parseVehicleJSON(data) {
                vehiclesToReturn = vehicles
            }
        }
        catch {
            return nil
        }
        
        return vehiclesToReturn
    }
    
    func parseVehicleJSON(_ vehicleData: Data) -> [Vehicle]? {
        let decoder = JSONDecoder()
        do {
            let decodedVehicles = try decoder.decode(SwapiVehicleResults.self, from: vehicleData)
            let vehicles = decodedVehicles.results
            return vehicles
            
        }
        catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }
}

// MARK: - Swapi Results
struct SwapiVehicleResults: Codable {
    let count: Int
    let next: String
    let previous: JSONNull?
    let results: [Vehicle]
}

// MARK: - Vehicle
struct Vehicle: Codable, Identifiable {
    let id = UUID()
    let name, model, manufacturer, costInCredits: String
    let length, maxAtmospheringSpeed, crew, passengers: String
    let cargoCapacity, consumables, vehicleClass: String
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
        case vehicleClass = "vehicle_class"
        case pilots, films, created, edited, url
    }
}
