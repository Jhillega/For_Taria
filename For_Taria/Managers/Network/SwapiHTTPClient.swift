//
//  SwapiService.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/7/23.
//

import Foundation
import SwiftUI

//MARK: SWAPI Client protocol and extension

protocol SWAPI_HTTPClient {
    func sendRequest<T: Decodable>(endpoint: SWAPI_Endpoint, responseModel: T.Type, searchTerm: Int?) async -> Result<T, RequestError>
}

extension SWAPI_HTTPClient {
    // Default implementation shared by all conforming types.
    // Switches between search URL and full-category URL based on whether a search term is present.
    func sendRequest<T: Decodable>(endpoint: SWAPI_Endpoint,
                                   responseModel: T.Type,
                                   searchTerm: Int? = nil) async -> Result<T, RequestError> {
        
        var urlString = ""
        
        if let term = searchTerm {
            urlString = endpoint.createIndividualEntryURLString(for: term)
        } else {
            urlString = endpoint.categoryfullURL
        }
        
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        
                
        do {
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            if response.statusCode > 299 {
                debugPrint("Status Code: \(response.statusCode) and search term: \(searchTerm ?? 1000)")
            }
                        
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    debugPrint("\(searchTerm ?? 99) failed to decode")
                    debugPrint("\(data)")
                    return .failure(.decode)
                }
                
                return .success(decodedResponse)
            case 401:
                debugPrint("\(searchTerm ?? 99) failed to authenticate")
                return .failure(.unauthorized)
            default:
                
                debugPrint("Searched failed for: \(String(describing: searchTerm)) with status code: \(response.statusCode)")
                return .failure(.unexpectedStatusCode)
            }
        }
        catch {
            debugPrint("\(searchTerm ?? 99) failed with error: \(error.localizedDescription)")
            return .failure(.unknown)
        }
        
    }
}

//MARK: Request enums
enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    // User-facing strings; only the most actionable errors have distinct messages.
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}
