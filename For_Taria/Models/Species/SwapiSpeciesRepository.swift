//
//  SwapiSpeciesRepository.swift
//  For_Taria
//
//  Created by Jason Hillegass on 12/4/24.
//

import Foundation

class SwapiSpeciesRepository {
    static let shared = SwapiSpeciesRepository()
    private var cacheReloadInterval: TimeInterval = SwapiCategoryEndpoints.species.cacheTime
    var service = SWAPIService()
    var cache = SwapiCache<URLRequest, [Species]>()
    
    func fetch(bypassCache: Bool = false) async throws -> [Species] {
        
        guard let url = URL(string: SwapiCategoryEndpoints.species.path) else {
            throw AppError.DataFetch(type: .invalidURL, errorString: "Unable to form URL for \(SwapiCategoryEndpoints.species.path)")
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
    
    private func networkFetch(_ request: URLRequest) async -> [Species] {
        
        let items = await service.fetch_Species_FromAGalaxyFarFarAway()
        
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
