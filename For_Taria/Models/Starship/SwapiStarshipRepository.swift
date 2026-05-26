//
//  SwapiStarshipRepository.swift
//  For_Taria
//
//  Created by Jason Hillegass on 12/3/24.
//

import Foundation

// Cache-then-network repository: returns cached results if present and non-empty,
// otherwise fetches from SWAPI and populates the cache for subsequent calls.
class SwapiStarshipRepository {
    static let shared = SwapiStarshipRepository()
    private var cacheReloadInterval: TimeInterval = SwapiCategoryEndpoints.starships.cacheTime
    var service = SWAPIService()
    var cache = SwapiCache<URLRequest, [Starship]>()
    
    func fetch(bypassCache: Bool = false) async throws -> [Starship] {
        
        guard let url = URL(string: SwapiCategoryEndpoints.starships.path) else {
            throw AppError.DataFetch(type: .invalidURL, errorString: "Unable to form URL for \(SwapiCategoryEndpoints.starships.path)")
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
    
    private func networkFetch(_ request: URLRequest) async -> [Starship] {
        
        let items = await service.fetch_Starships_FromAGalaxyFarFarAway()
        
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
