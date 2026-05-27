//
//  SWAPIService.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/7/23.
//

import Foundation

protocol SWAPIServicable {
    // general fetch all functions
    func fetch_People_FromAGalaxyFarFarAway() async -> Result<SwapiPeopleResults, RequestError>
    func fetch_Planets_FromAGalaxyFarFarAway() async -> Result<SwapiPlanetResults, RequestError>
    func fetch_Starships_FromAGalaxyFarFarAway() async -> Result<SwapiStarshipResults, RequestError>
    func fetch_Vehicles_FromAGalaxyFarFarAway() async -> Result<SwapiVehicleResults, RequestError>
    func fetch_Species_FromAGalaxyFarFarAway() async -> Result<SwapiSpeciesResults, RequestError>
    func fetch_Films_About_FromAGalaxyFarFarAway() async -> Result<SwapiFilmResults, RequestError>
}

struct SWAPIService: SWAPI_HTTPClient, SWAPIServicable {    
    // MARK: - Fetch all functions
    func fetch_People_FromAGalaxyFarFarAway() async -> Result<SwapiPeopleResults, RequestError> {
        return await sendRequest(endpoint: SwapiCategoryEndpoints.people, responseModel: SwapiPeopleResults.self)
    }
    
    func fetchPerson(id: Int) async -> Result<Person, RequestError> {
        return await sendRequest(endpoint: SwapiCategoryEndpoints.people, responseModel: Person.self, searchTerm: id)
    }
    
    func fetch_Planets_FromAGalaxyFarFarAway() async -> Result<SwapiPlanetResults, RequestError> {
        return await sendRequest(endpoint: SwapiCategoryEndpoints.planets, responseModel: SwapiPlanetResults.self)
    }
    
    func fetch_Starships_FromAGalaxyFarFarAway() async -> Result<SwapiStarshipResults, RequestError> {
        return await sendRequest(endpoint: SwapiCategoryEndpoints.starships, responseModel: SwapiStarshipResults.self)
    }
    
    func fetch_Vehicles_FromAGalaxyFarFarAway() async -> Result<SwapiVehicleResults, RequestError> {
        return await sendRequest(endpoint: SwapiCategoryEndpoints.vehicles, responseModel: SwapiVehicleResults.self)
    }
    
    func fetch_Species_FromAGalaxyFarFarAway() async -> Result<SwapiSpeciesResults, RequestError> {
        return await sendRequest(endpoint: SwapiCategoryEndpoints.species, responseModel: SwapiSpeciesResults.self)
    }
    
    func fetch_Films_About_FromAGalaxyFarFarAway() async -> Result<SwapiFilmResults, RequestError> {
        return await sendRequest(endpoint: SwapiCategoryEndpoints.films, responseModel: SwapiFilmResults.self)
    }
}
