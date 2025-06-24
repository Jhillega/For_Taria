//
//  MockServiceManager.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/24/25.
//

final class MockServiceManager {
    let mockService: MockService = MockService.shared
    let shared = MockServiceManager()
    
    func makeTestPlanet() -> Planet {
        return MockService.testPlanet
    }
}
