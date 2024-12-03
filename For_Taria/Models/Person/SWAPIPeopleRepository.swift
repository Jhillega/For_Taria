//
//  SWAPIPeopleRepository.swift
//  For_Taria
//
//  Created by Jason Hillegass on 12/3/24.
//

import Foundation

class SWAPIPeopleRepository {
    static let shared = SWAPIPeopleRepository()
    private var cacheReloadInterval: TimeInterval = SwapiCategoryEndpoints.people.cacheTime
    var service = SWAPIService()
    
    func fetch(bypassCache: Bool = false) async throws -> [Person] {
        
        guard let url = URL(string: SwapiCategoryEndpoints.people.path) else {
            throw AppError.DataFetch(type: .invalidURL, errorString: "Unable to form URL for \(SwapiCategoryEndpoints.people.path)")
        }
        
        let request = URLRequest(url: url)
        
        if bypassCache {
            return await networkFetch(request)
        } else {
            
            do {
                let results = try await URLCacheManager.shared.retrieve(for: request, as: SwapiPeopleResults.self)
                
                return results.results ?? []
            } catch {
                return await networkFetch(request)
            }
        }
        
    }
    
    private func networkFetch(_ request: URLRequest) async -> [Person] {
        
        let items = await service.fetch_People_FromAGalaxyFarFarAway()
        
        switch items {
        case .success(let success):
            return success.results ?? []
        case .failure(let failure):
            debugPrint(failure.localizedDescription)
            return []
        }
    }
    
}
