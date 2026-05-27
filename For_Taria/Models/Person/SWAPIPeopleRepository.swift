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
    let cache = SwapiCache<URLRequest, [Person]>()
    
    func fetch(bypassCache: Bool = false, individual: Bool = false) async throws -> [Person] {
        
        guard let url = URL(string: SwapiCategoryEndpoints.people.path) else {
            throw AppError.DataFetch(type: .invalidURL, errorString: "Unable to form URL for \(SwapiCategoryEndpoints.people.path)")
        }
        
        let request = URLRequest(url: url)
        
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
                
                return people
            }
            
            return await networkFetch(request)
        } else {
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
                
                return people
            }
            
            guard let results = cache.value(forKey: request), results.isEmpty == false else {
                return await networkFetch(request)
            }
            
            return results
        }
    }
    
    private func networkFetch(_ request: URLRequest) async -> [Person] {
        
        let items = await service.fetch_People_FromAGalaxyFarFarAway()
        
        switch items {
        case .success(let success):
            cache.insert(success.results ?? [], forKey: request)
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
