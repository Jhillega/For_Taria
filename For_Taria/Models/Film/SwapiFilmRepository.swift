//
//  SwapiFilmRepository.swift
//  For_Taria
//
//  Created by Jason Hillegass on 12/3/24.
//

import Foundation

class SwapiFilmRepository {
    static let shared = SwapiFilmRepository()
    private var cacheReloadInterval: TimeInterval = SwapiCategoryEndpoints.films.cacheTime
    var service = SWAPIService()
    var cache = SwapiCache<URLRequest, [Film]>()
    
    func fetch(bypassCache: Bool = false) async throws -> [Film] {
        
        guard let url = URL(string: SwapiCategoryEndpoints.films.path) else {
            throw AppError.DataFetch(type: .invalidURL, errorString: "Unable to form URL for \(SwapiCategoryEndpoints.films.path)")
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
    
    private func networkFetch(_ request: URLRequest) async -> [Film] {
        
        let items = await service.fetch_Films_About_FromAGalaxyFarFarAway()
        
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
