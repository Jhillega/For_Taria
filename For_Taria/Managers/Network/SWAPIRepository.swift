//
//  SWAPIRepository.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/26.
//

import Foundation

class SWAPIRepository {
    static let shared = SWAPIRepository()
    private var cacheReloadInterval: TimeInterval = 60 * 60
    var service = SWAPIService()
    let cache = SwapiCache<SwapiCategoryEndpoints, [any SWAPIRetrievable]>()
    
    func fetch(bypassCache: Bool = false, getAll: Bool = true, for category: SwapiCategoryEndpoints) async throws -> [any SWAPIRetrievable] {
        if bypassCache {
            return try await makeCallForCategory(category, getAll: getAll)
        } else {
            guard let results = cache.value(forKey: category) else {
                return try await makeCallForCategory(category, getAll: getAll)
            }
            
            return results
        }
    }
    
    func makeCallForCategory(_ category: SwapiCategoryEndpoints, getAll: Bool) async throws -> [any SWAPIRetrievable] {
        
        switch category {
        case .people:
            return await getCharacters(individual: getAll)
        case .planets:
            return await SwapiPlanetRepository.shared.getPlanets()
        case .vehicles:
            return try await SwapiVehicleRepository.shared.fetch(bypassCache: getAll)
        case .starships:
            return try await SwapiStarshipRepository.shared.fetch(bypassCache: getAll)
        case .films:
            return try await SwapiFilmRepository.shared.fetch(bypassCache: getAll)
        case .species:
            return try await SwapiSpeciesRepository.shared.fetch(bypassCache: getAll)
        }
    }
}

// MARK: People/Characters
extension SWAPIRepository {
    
    
    func getCharacters(individual: Bool = true) async -> [Person] {
        if individual {
            let people: [Person] = await withTaskGroup(of: Person.self, returning: [Person].self) { group in
                for entry in 1 ... SwapiCategoryEndpoints.people.totalNumberOfEntries {
                    if entry != 17 {
                        group.addTask {
                            await self.networkFetchPerson(entryNumber: entry)
                        }
                    }
                }

                var decodedPeople = [Person]()

                for await person in group {
                    if person.name != "Unknown" {
                        decodedPeople.append(person)
                    }
                }

                return decodedPeople
            }
            
            cache.insert(people, forKey: .people)
            return people
        }
        
        return await networkFetchSample()
    }
    
    private func networkFetchSample() async -> [Person] {
        
        let items = await service.fetch_People_FromAGalaxyFarFarAway()
        
        switch items {
        case .success(let success):
            cache.insert(success.results ?? [], forKey: .people)
            return success.results ?? []
        case .failure(let failure):
            debugPrint(failure.localizedDescription)
            return []
        }
    }
    
    func networkFetchPerson(entryNumber: Int) async -> Person {
        let character = await service.fetchPerson(id: entryNumber)
        
        switch character {
        case .success(let success):
            return success
        case .failure(let failure):
            debugPrint(failure.localizedDescription)
            return Person(name: "Unknown", height: nil, mass: nil, hairColor: "Unknown", skinColor: nil, eyeColor: "Unknown", birthYear: "Unknown", gender: .nA, homeworld: nil, films: nil, species: nil, vehicles: nil, starships: nil, created: nil, edited: nil, url: nil)
        }
        
        
    }
}

// MARK: - Planets
extension SWAPIRepository {
    func getPlanets() async throws -> [Planet] {
        await SwapiPlanetRepository.shared.getPlanets()
    }
}
