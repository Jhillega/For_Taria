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
    func sendRequest<T: Decodable>(endpoint: SWAPI_Endpoint, responseModel: T.Type, searchTerm: String?) async -> Result<T, RequestError>
}

extension SWAPI_HTTPClient {
    func sendRequest<T: Decodable>(endpoint: SWAPI_Endpoint,
                                   responseModel: T.Type,
                                   searchTerm: String? = nil) async -> Result<T, RequestError> {
        
        var urlString = ""
        
        if let term = searchTerm {
            urlString = endpoint.createSearchURLString(with: term)
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
            
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    return .failure(.decode)
                }
                
                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        }
        catch {
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
