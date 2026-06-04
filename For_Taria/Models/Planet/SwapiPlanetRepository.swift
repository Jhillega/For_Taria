//
//  SwapiPlanetRepository.swift
//  For_Taria
//
//  Created by Jason Hillegass on 12/3/24.
//

import Foundation

// Cache-then-network repository: returns cached results if present and non-empty,
// otherwise fetches from SWAPI and populates the cache for subsequent calls.
class SwapiPlanetRepository {
    static let shared = SwapiPlanetRepository()
    private var cacheReloadInterval: TimeInterval = SwapiCategoryEndpoints.planets.cacheTime
    var service = SWAPIService()
    var cache = SwapiCache<SwapiCategoryEndpoints, [Planet]>()
    
    func getPlanets(all: Bool = true) async -> [Planet] {
        if all {
            let planets: [Planet] = await withTaskGroup(of: Planet.self, returning: [Planet].self) { group in
                for entry in 1 ... SwapiCategoryEndpoints.planets.totalNumberOfEntries {
                    group.addTask {
                        await self.networkFetchPlanet(entryNumber: entry) ?? Planet(name: "Unknown", rotationPeriod: "Unknown", orbitalPeriod: "Unknown", diameter: "Unknown", climate: "Unknown", gravity: "Unknown", terrain: "Unknown", surfaceWater: "Unknown", population: "Unknown", residents: [], films: [], created: "Date()", edited: "Date()", url: "Unknown")
                    }
                }
                
                var decodedPlanets = [Planet]()
                
                for await planet in group {
                    decodedPlanets.append(planet)
                }
                
                return decodedPlanets
            }
            
            cache.insert(planets, forKey: .planets)
            return planets
        }
        
        return await networkFetchSample()
    }
    
    private func networkFetchPlanet(entryNumber: Int) async -> Planet? {
        let planet = await service.fetchPlanet(id: entryNumber)
        
        switch planet {
        case .success(let success):
            return success
        case .failure(let failure):
            debugPrint(failure.localizedDescription)
            return nil
        }
    }
    
    private func networkFetchSample() async -> [Planet] {
        
        let items = await service.fetch_Planets_FromAGalaxyFarFarAway()
        
        switch items {
        case .success(let success):
            cache.insert(success.results ?? [], forKey: .planets)
            return success.results ?? []
        case .failure(let failure):
            debugPrint(failure.localizedDescription)
            return []
        }
    }
    
}
