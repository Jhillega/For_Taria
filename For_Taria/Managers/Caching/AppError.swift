//
//  AppError.swift
//  For_Taria
//
//  Created by Jason Hillegass on 12/3/24.
//

import Foundation

struct AppError {
    
    struct Network: Error {
        enum ErrorType {
            case general
            case invalidResponse
            case unableToDecode
            case badRequest
            case notFound
        }
        
        let code: Int
        let type: ErrorType
        let response: HTTPURLResponse?
        let data: Data
        let errorString: String
    }
    
    struct DataFetch: Error {
        enum ErrorType {
            case general
            case invalidURL
            case unableToDecode
        }
        
        let type: ErrorType
        let errorString: String
        let data: Data? = Data()
    }
}
