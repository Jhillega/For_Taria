//
//  StarWarsFilmDataModel.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import Foundation
import UIKit

// MARK: - SwapiFilmResults
struct SwapiFilmResults: Codable {
    let count: Int
    let next, previous: JSONNull?
    let results: [Film]
}

// MARK: - Film
struct Film: Codable, Identifiable, SWAPISearchResultPresentable {
    let id = UUID()
    let name: String
    let episodeID: Int
    let openingCrawl, director, producer, releaseDate: String
    let characters, planets, starships, vehicles: [String]
    let species: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name = "title"
        case episodeID = "episode_id"
        case openingCrawl = "opening_crawl"
        case director, producer
        case releaseDate = "release_date"
        case characters, planets, starships, vehicles, species, created, edited, url
    }
}
