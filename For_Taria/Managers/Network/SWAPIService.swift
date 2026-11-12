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
    
    // People
    func fetch_People_FromAGalaxyFarFarAway() async -> Result<SwapiPeopleResults, RequestError> {
        return await sendRequest(endpoint: SwapiCategoryEndpoints.people, responseModel: SwapiPeopleResults.self)
    }
    
    func fetchPerson(id: Int) async -> Result<Person, RequestError> {
        return await sendRequest(endpoint: SwapiCategoryEndpoints.people, responseModel: Person.self, searchTerm: id)
    }
    
    // Planets
    func fetch_Planets_FromAGalaxyFarFarAway() async -> Result<SwapiPlanetResults, RequestError> {
        return await sendRequest(endpoint: SwapiCategoryEndpoints.planets, responseModel: SwapiPlanetResults.self)
    }
    
    func fetchPlanet(id: Int) async -> Result<Planet, RequestError> {
        return await sendRequest(endpoint: SwapiCategoryEndpoints.planets, responseModel: Planet.self, searchTerm: id)
    }
    
    // Starships
    func fetch_Starships_FromAGalaxyFarFarAway() async -> Result<SwapiStarshipResults, RequestError> {
        return await sendRequest(endpoint: SwapiCategoryEndpoints.starships, responseModel: SwapiStarshipResults.self)
    }
    
    func fetchStarship(id: Int) async -> Result<Starship, RequestError> {
        return await sendRequest(endpoint: SwapiCategoryEndpoints.starships, responseModel: Starship.self, searchTerm: id)
    }
    
    // Vehicles
    func fetch_Vehicles_FromAGalaxyFarFarAway() async -> Result<SwapiVehicleResults, RequestError> {
        return await sendRequest(endpoint: SwapiCategoryEndpoints.vehicles, responseModel: SwapiVehicleResults.self)
    }
    
    func fetchVehicle(id: Int) async -> Result<Vehicle, RequestError> {
        return await sendRequest(endpoint: SwapiCategoryEndpoints.vehicles, responseModel: Vehicle.self, searchTerm: id)
    }
    
    // Species
    func fetch_Species_FromAGalaxyFarFarAway() async -> Result<SwapiSpeciesResults, RequestError> {
        return await sendRequest(endpoint: SwapiCategoryEndpoints.species, responseModel: SwapiSpeciesResults.self)
    }
    
    func fetchSpecies(id: Int) async -> Result<Species, RequestError> {
        return await sendRequest(endpoint: SwapiCategoryEndpoints.species, responseModel: Species.self, searchTerm: id)
    }
    
    // Films
    func fetch_Films_About_FromAGalaxyFarFarAway() async -> Result<SwapiFilmResults, RequestError> {
        return await sendRequest(endpoint: SwapiCategoryEndpoints.films, responseModel: SwapiFilmResults.self)
    }
    
    func fetchFilm(id: Int) async -> Result<Film, RequestError> {
        return await sendRequest(endpoint: SwapiCategoryEndpoints.films, responseModel: Film.self, searchTerm: id)
    }
}
