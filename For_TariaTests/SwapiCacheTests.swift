import Testing
import Foundation
@testable import For_Taria

@Suite("SwapiCache Tests")
struct SwapiCacheTests {

    @Test("Insert and retrieve a value")
    func insertAndRetrieve() {
        let cache = SwapiCache<String, Int>()
        cache.insert(42, forKey: "answer")
        #expect(cache.value(forKey: "answer") == 42)
    }

    @Test("Missing key returns nil")
    func missingKeyReturnsNil() {
        let cache = SwapiCache<String, Int>()
        #expect(cache.value(forKey: "missing") == nil)
    }

    @Test("Expired value returns nil")
    func expiredValueReturnsNil() {
        var simulatedTime = Date(timeIntervalSinceReferenceDate: 0)
        let cache = SwapiCache<String, Int>(
            dateProvider: { simulatedTime },
            entryLifetime: 60
        )
        cache.insert(99, forKey: "key")
        #expect(cache.value(forKey: "key") == 99)

        simulatedTime = simulatedTime.addingTimeInterval(61)
        #expect(cache.value(forKey: "key") == nil)
    }

    @Test("Remove value makes key return nil")
    func removeValue() {
        let cache = SwapiCache<String, String>()
        cache.insert("hello", forKey: "greeting")
        cache.removeValue(forKey: "greeting")
        #expect(cache.value(forKey: "greeting") == nil)
    }

    @Test("Subscript get and set")
    func subscriptGetSet() {
        let cache = SwapiCache<Int, String>()
        cache[1] = "one"
        #expect(cache[1] == "one")

        cache[1] = nil
        #expect(cache[1] == nil)
    }

    @Test("Multiple keys are independent")
    func multipleKeysAreIndependent() {
        let cache = SwapiCache<String, Int>()
        cache.insert(1, forKey: "a")
        cache.insert(2, forKey: "b")
        cache.insert(3, forKey: "c")

        #expect(cache.value(forKey: "a") == 1)
        #expect(cache.value(forKey: "b") == 2)
        #expect(cache.value(forKey: "c") == 3)

        cache.removeValue(forKey: "b")
        #expect(cache.value(forKey: "a") == 1)
        #expect(cache.value(forKey: "b") == nil)
        #expect(cache.value(forKey: "c") == 3)
    }
}
