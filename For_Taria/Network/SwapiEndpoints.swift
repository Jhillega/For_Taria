//
//  SwapiEndpoints.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/7/23.
//

import Foundation
//MARK: Swapi endpoint enums
enum SwapiCategoryEndpoints {
    case people
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
    var fullURL: String { get }
}


extension SwapiCategoryEndpoints: SWAPI_Endpoint {
    var baseURL: String {
        switch self {
        default:
            return "https://swapi.dev/api/"
        }
    }
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
    
    var fullURL: String {
        return baseURL + path
    }
}
