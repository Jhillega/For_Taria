//
//  For_TariaTests.swift
//  For_TariaTests
//
//  Created by Jason Hillegass on 5/19/26.
//

import Testing

struct For_TariaTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        // Swift Testing Documentation
        // https://developer.apple.com/documentation/testing
        let result = 2 + 2
        #expect(result == 4)
    }

}
