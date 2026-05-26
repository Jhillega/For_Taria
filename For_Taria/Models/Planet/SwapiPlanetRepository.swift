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
    var cache = SwapiCache<URLRequest, [Planet]>()
    
    func fetch(bypassCache: Bool = false) async throws -> [Planet] {
        
        guard let url = URL(string: SwapiCategoryEndpoints.planets.path) else {
            throw AppError.DataFetch(type: .invalidURL, errorString: "Unable to form URL for \(SwapiCategoryEndpoints.planets.path)")
        }
        
        let request = URLRequest(url: url)
        
        if bypassCache {
            return await networkFetch(request)
        } else {
            
            guard let results = cache.value(forKey: request), results.isEmpty == false else {
                return await networkFetch(request)
            }
            
            return results
        }
    }
    
    private func networkFetch(_ request: URLRequest) async -> [Planet] {
        
        let items = await service.fetch_Planets_FromAGalaxyFarFarAway()
        
        switch items {
        case .success(let success):
            cache.insert(success.results ?? [], forKey: request)
            return success.results ?? []
        case .failure(let failure):
            debugPrint(failure.localizedDescription)
            return []
        }
    }
    
}
