//
//  StarWarsFilmDataModel.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import Foundation
import SwiftUI


class StarWarsFilmDataModel: ObservableObject {
    // fetched films
    @Published private var currentFetchedFilms = [Film]()
    
    let baseFilmURL = "https://swapi.dev/api/films/"
    
    func fetchFilmsAboutAGalaxyFarFarAway() async -> [Film]? {
        //set return container for film objects
        var filmsToReturn: [Film] = []
        
        // create and validate url
        guard let url = URL(string: baseFilmURL) else {
            fatalError("Bad URL")
        }
        
        // build request
        let urlRequest = URLRequest(url: url)
        
        // do and catch for tasks
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            // verify response
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return nil
            }
            // map data
            if let films = self.parseFilmJson(data) {
                filmsToReturn = films
            }
            
        }
        catch {
            return nil
        }
        
        return filmsToReturn
    }
    
    func parseFilmJson(_ filmData: Data) -> [Film]? {
        let decoder = JSONDecoder()
        do {
            let decodedFilms = try decoder.decode(SwapiFilmResults.self, from: filmData)
            let filmsToReturn = decodedFilms.results
            return filmsToReturn
        }
        catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }
}

// MARK: - SwapiFilmResults
struct SwapiFilmResults: Codable {
    let count: Int
    let next, previous: JSONNull?
    let results: [Film]
}

// MARK: - Film
struct Film: Codable, Identifiable {
    let id = UUID()
    let title: String
    let episodeID: Int
    let openingCrawl, director, producer, releaseDate: String
    let characters, planets, starships, vehicles: [String]
    let species: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case title
        case episodeID = "episode_id"
        case openingCrawl = "opening_crawl"
        case director, producer
        case releaseDate = "release_date"
        case characters, planets, starships, vehicles, species, created, edited, url
    }
}
