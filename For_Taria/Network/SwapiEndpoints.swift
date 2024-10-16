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
    var categoryfullURL: String { get }
    
    func createSearchURL(with searchTerm: String, for categoryEndpoint: SWAPI_Endpoint) -> URL?
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
    
    func createSearchURL(with searchTerm: String, for categoryEndpoint: SWAPI_Endpoint) -> URL? {
        guard let url = URL(string: categoryEndpoint.categoryfullURL + "?search=" + searchTerm) else {
            print("Bad url for individual search")
            return nil
        }
        
        return url
    }
}
