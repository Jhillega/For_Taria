//
//  StarWarsPersonDataModel.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import Foundation
import Combine

@MainActor class StarWarsPersonDataModel: ObservableObject {
    @Published var currentModels = [Person]()
    
    let basePeopleURL = "https://swapi.dev/api/people/"
    
    func searchPeopleFromAGalaxyFarFarAway() async {
        guard let url = URL(string: basePeopleURL) else {
            print("BAD URL!!!!")
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("error parsing")
                return
            }
            if let people = self.parsePeopleJson(data) {
                self.currentModels = people
            }
            
        }
        catch {
            return
        }
    }
    
    func fetchPeopleFromAGalaxyFarFarAway(completion:@escaping ([Person]) -> ()) {
        guard let url = URL(string: basePeopleURL) else {
            print("Invalid url ... jack!")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                if error != nil {
                    print("Error: \(String(describing: error))")
                }
                return
            }

            let people = try! JSONDecoder().decode(SwapiPeopleResults.self, from: data)
            DispatchQueue.main.async {
                completion(people.results)
            }
            
        }
        .resume()
        
        
    }
    
    func parsePeopleJson(_ peopleData: Data) -> [Person]? {
        let decoder = JSONDecoder()
        do {
            let decodedPeople = try decoder.decode(SwapiPeopleResults.self, from: peopleData)
            let peopleToReturn = decodedPeople.results
            return peopleToReturn
        }
        catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }

}

// MARK: - SwapiResults
struct SwapiPeopleResults: Codable {
    let count: Int
    let next: String
    let previous: JSONNull?
    let results: [Person]
}

// MARK: - Result
struct Person: Codable, Identifiable {
    let id = UUID()
    let name, height, mass, hairColor: String
    let skinColor, eyeColor, birthYear: String
    let gender: Gender
    let homeworld: String
    let films, species, vehicles, starships: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, height, mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender, homeworld, films, species, vehicles, starships, created, edited, url
    }
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
    case nA = "n/a"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
