//
//  StarWarsSpeciesDataModel.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import Foundation

// MARK: Publisher Object
class StarWarsSpeciesDataModel: ObservableObject {
    @Published private var currentFetchedSpecies = [Species]()
    
    let baseSpeciesURL = "https://swapi.dev/api/species/"
    
    func fetchSpeciesFromAGalaxyFarFarAway() async -> [Species]? {
        var speciesToReturn = [Species]()
        
        // url
        guard let url = URL(string: baseSpeciesURL) else {
            fatalError("Bad URL Jack!!!")
        }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return nil
            }
            
            if let species = self.parseSpeciesJson(data) {
                speciesToReturn = species
            }
        }
        catch {
            return nil
        }
        
        return speciesToReturn
    }
    
    func parseSpeciesJson(_ filmData: Data) -> [Species]? {
        let decoder = JSONDecoder()
        do {
            let decodedFilms = try decoder.decode(SwapiSpeciesResults.self, from: filmData)
            let speciesToReturn = decodedFilms.results
            return speciesToReturn
        }
        catch {
            print("Error: \(error)")
            return nil
        }
    }
}


// MARK: - SwapiSpeciesResults
struct SwapiSpeciesResults: Codable {
    let count: Int
    let next: String
    let previous: JSONNull?
    let results: [Species]
}

// MARK: - Species
struct Species: Codable, Identifiable {
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

