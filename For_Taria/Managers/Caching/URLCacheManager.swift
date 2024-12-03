//
//  URLCacheManager.swift
//  For_Taria
//
//  Created by Jason Hillegass on 12/3/24.
//

import Foundation

class URLCacheManager {
    static let shared = URLCacheManager()
    private let urlCache = URLCache.shared
    
    func store(request: URLRequest, response: URLResponse, data: Data) {
        let cachedData = CachedURLResponse(response: response, data: data)
        self.urlCache.storeCachedResponse(cachedData, for: request)
    }
    
    func retrieve<T: Decodable>(for request: URLRequest, as type: T.Type) async throws -> T {
        guard let data = self.urlCache.cachedResponse(for: request)?.data, let type = try? JSONDecoder().decode(type, from: data) else {
            throw AppError.DataFetch(type: .general, errorString: "Unable to retrieve cached data for \(request.url?.absoluteString ?? "url")")
        }
        
        return type
    }
    
    func purge() {
        urlCache.removeAllCachedResponses()
    }
}
