//
//  SWAPIPeopleRepository.swift
//  For_Taria
//
//  Created by Jason Hillegass on 12/3/24.
//

import Foundation

// Cache-then-network repository: returns cached results if present and non-empty,
// otherwise fetches from SWAPI and populates the cache for subsequent calls.
class SWAPIPeopleRepository {
    static let shared = SWAPIPeopleRepository()
    private var cacheReloadInterval: TimeInterval = SwapiCategoryEndpoints.people.cacheTime
    var service = SWAPIService()
    let cache = SwapiCache<SwapiCategoryEndpoints, [Person]>()
    
    func fetch(bypassCache: Bool = false, individual: Bool = false) async throws -> [Person] {
        if bypassCache {
            if individual {
                let people: [Person] = await withTaskGroup(of: Person.self, returning: [Person].self) { group in
                    for entry in 1 ... SwapiCategoryEndpoints.people.totalNumberOfEntries {
                        group.addTask {
                            await self.networkFetchPerson(entryNumber: entry)
                        }
                    }

                    var decodedPeople = [Person]()

                    for await person in group {
                        decodedPeople.append(person)
                    }

                    return decodedPeople
                }
                
                cache.insert(people, forKey: .people)
                return people
            }
            
            return await networkFetch()
        } else {
            guard let results = cache.value(forKey: .people), results.isEmpty == false else {
                if individual {
                    let people: [Person] = await withTaskGroup(of: Person.self, returning: [Person].self) { group in
                        for entry in 1 ... SwapiCategoryEndpoints.people.totalNumberOfEntries {
                            group.addTask {
                                await self.networkFetchPerson(entryNumber: entry)
                            }
                        }

                        var decodedPeople = [Person]()

                        for await person in group {
                            decodedPeople.append(person)
                        }

                        return decodedPeople
                    }
                    cache.insert(people, forKey: .people)
                    return people
                }
                
                return await networkFetch()
            }
            
            return results
        }
    }
    
    private func networkFetch() async -> [Person] {
        
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
