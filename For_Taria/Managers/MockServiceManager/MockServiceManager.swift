//
//  MockServiceManager.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/24/25.
//

// Thin wrapper over MockService; provides a single call site for preview data creation.
final class MockServiceManager {
    let mockService: MockService = MockService.shared
    let shared = MockServiceManager()
    
    func makeTestPlanet() -> Planet {
        return MockService.testPlanet
    }
}
