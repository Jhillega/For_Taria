//
//  SwapiVehicleRepository.swift
//  For_Taria
//
//  Created by Jason Hillegass on 12/4/24.
//

import Foundation

// Cache-then-network repository: returns cached results if present and non-empty,
// otherwise fetches from SWAPI and populates the cache for subsequent calls.
class SwapiVehicleRepository {
    static let shared = SwapiVehicleRepository()
    private var cacheReloadInterval: TimeInterval = SwapiCategoryEndpoints.vehicles.cacheTime
    var service = SWAPIService()
    var cache = SwapiCache<URLRequest, [Vehicle]>()
    
    func fetch(bypassCache: Bool = false) async throws -> [Vehicle] {
        
        guard let url = URL(string: SwapiCategoryEndpoints.vehicles.path) else {
            throw AppError.DataFetch(type: .invalidURL, errorString: "Unable to form URL for \(SwapiCategoryEndpoints.vehicles.path)")
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
    
    private func networkFetch(_ request: URLRequest) async -> [Vehicle] {
        
        let items = await service.fetch_Vehicles_FromAGalaxyFarFarAway()
        
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
