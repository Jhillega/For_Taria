//
//  SwapiEndpoints.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/7/23.
//

import Foundation
//MARK: Swapi endpoint enums
enum SwapiCategoryEndpoints: Int, CaseIterable {
    case people = 0
    case planets
    case vehicles
    case starships
    case films
    case species
}

//MARK: SWAPI endpoint protocols
protocol SWAPI_Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var categoryfullURL: String { get }
    
    func createSearchURLString(with searchTerm: String) -> String
}

//MARK: SwapiEndpoint default implementation
extension SwapiCategoryEndpoints: SWAPI_Endpoint {
    // swapi base url
    var baseURL: String {
        switch self {
        default:
            return "https://swapi.py4e.com/api/"
        }
    }
    // variable for category url
    var path: String {
        switch self {
        case .people:
            return "people/"
        case .planets:
            return "planets/"
        case .vehicles:
            return "vehicles/"
        case .starships:
            return "starships/"
        case .films:
            return "films/"
        case .species:
            return "species/"
        }
    }
    
    // url output for categories
    var categoryfullURL: String {
        return baseURL + path
    }
    
    var cacheTime: TimeInterval {
        switch self {
        case .people:
            60 * 5
        case .planets:
            60 * 5
        case .vehicles:
            60 * 5
        case .starships:
            60 * 5
        case .films:
            60 * 5
        case .species:
            60 * 5
        }
    }
    
    var totalNumberOfEntries: Int {
        switch self {
        case .people:
            return 83
        case .planets:
            return 60
        case .vehicles:
            return 76
        case .starships:
            return 75
        case .films:
            return 6
        case .species:
            return 37
        }
    }
    
    func createSearchURLString(with searchTerm: String) -> String {
        return self.categoryfullURL + "?search=" + searchTerm
    }
}
