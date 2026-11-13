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

    // MARK: - Persistence

    /// Unique cache name per test so runs never share files.
    private func uniqueName() -> String {
        "SwapiCacheTests-\(UUID().uuidString)"
    }

    private func cacheFileURL(named name: String) throws -> URL {
        let folder = try #require(FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first)
        return folder.appendingPathComponent(name + ".cache")
    }

    @Test("Persisted values are restored by a new instance")
    func persistedValuesSurviveRelaunch() throws {
        let name = uniqueName()
        let url = try cacheFileURL(named: name)
        defer { try? FileManager.default.removeItem(at: url) }

        let first = SwapiCache<String, Int>(persistedAs: name)
        first.insert(42, forKey: "answer")
        first.insert(7, forKey: "lucky")

        let second = SwapiCache<String, Int>(persistedAs: name)
        #expect(second.value(forKey: "answer") == 42)
        #expect(second.value(forKey: "lucky") == 7)
    }

    @Test("Removed values are not restored")
    func removedValuesAreNotRestored() throws {
        let name = uniqueName()
        let url = try cacheFileURL(named: name)
        defer { try? FileManager.default.removeItem(at: url) }

        let first = SwapiCache<String, Int>(persistedAs: name)
        first.insert(1, forKey: "a")
        first.insert(2, forKey: "b")
        first.removeValue(forKey: "a")

        let second = SwapiCache<String, Int>(persistedAs: name)
        #expect(second.value(forKey: "a") == nil)
        #expect(second.value(forKey: "b") == 2)
    }

    @Test("Expired entries are not restored")
    func expiredEntriesAreNotRestored() throws {
        let name = uniqueName()
        let url = try cacheFileURL(named: name)
        defer { try? FileManager.default.removeItem(at: url) }

        // A negative lifetime stores entries that are already expired.
        let first = SwapiCache<String, Int>(persistedAs: name, entryLifetime: -1)
        first.insert(1, forKey: "stale")

        let second = SwapiCache<String, Int>(persistedAs: name)
        #expect(second.value(forKey: "stale") == nil)
    }

    @Test("Differently named caches do not share data")
    func namedCachesAreIndependent() throws {
        let nameA = uniqueName()
        let nameB = uniqueName()
        let urlA = try cacheFileURL(named: nameA)
        let urlB = try cacheFileURL(named: nameB)
        defer {
            try? FileManager.default.removeItem(at: urlA)
            try? FileManager.default.removeItem(at: urlB)
        }

        SwapiCache<String, Int>(persistedAs: nameA).insert(1, forKey: "key")

        let other = SwapiCache<String, Int>(persistedAs: nameB)
        #expect(other.value(forKey: "key") == nil)
    }

    @Test("Corrupt cache file is ignored")
    func corruptFileIsIgnored() throws {
        let name = uniqueName()
        let url = try cacheFileURL(named: name)
        defer { try? FileManager.default.removeItem(at: url) }

        try Data("not json".utf8).write(to: url)

        let cache = SwapiCache<String, Int>(persistedAs: name)
        #expect(cache.value(forKey: "anything") == nil)

        // The cache is still usable and overwrites the bad file.
        cache.insert(5, forKey: "five")
        let reloaded = SwapiCache<String, Int>(persistedAs: name)
        #expect(reloaded.value(forKey: "five") == 5)
    }

    @Test("Codable values round trip through persistence")
    func codableModelsRoundTrip() throws {
        let name = uniqueName()
        let url = try cacheFileURL(named: name)
        defer { try? FileManager.default.removeItem(at: url) }

        let first = SwapiCache<SwapiCategoryEndpoints, [String]>(persistedAs: name)
        first.insert(["Luke", "Leia"], forKey: .people)

        let second = SwapiCache<SwapiCategoryEndpoints, [String]>(persistedAs: name)
        #expect(second.value(forKey: .people) == ["Luke", "Leia"])
        #expect(second.value(forKey: .planets) == nil)
    }
}
