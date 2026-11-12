import Testing
import Foundation
@testable import For_Taria

// These tests seed the species repository's cache so no network calls are made.
// Serialized because they share SwapiSpeciesRepository.shared.
@Suite("SWAPIRepository caching Tests", .serialized)
struct SwapiRepositoryCacheTests {

    private func makeSpecies(named name: String) throws -> Species {
        let json = #"{"name": "\#(name)"}"#
        return try JSONDecoder().decode(Species.self, from: Data(json.utf8))
    }

    private var speciesRequest: URLRequest {
        URLRequest(url: URL(string: SwapiCategoryEndpoints.species.path)!)
    }

    @Test("Non-bypass fetch passes through to the category repository cache")
    func nonBypassFetchUsesCategoryCache() async throws {
        let seeded = try makeSpecies(named: "Wookiee")
        let request = speciesRequest
        SwapiSpeciesRepository.shared.cache.insert([seeded], forKey: request)
        defer { SwapiSpeciesRepository.shared.cache.removeValue(forKey: request) }

        // Fresh repository so its top-level cache starts empty
        let repository = SWAPIRepository()
        let results = try await repository.fetch(for: .species)

        #expect(results.count == 1)
        #expect(results.first?.name == "Wookiee")
    }

    @Test("Results are stored in the top-level cache")
    func resultsAreCachedAtTopLevel() async throws {
        let seeded = try makeSpecies(named: "Hutt")
        let request = speciesRequest
        SwapiSpeciesRepository.shared.cache.insert([seeded], forKey: request)

        let repository = SWAPIRepository()
        _ = try await repository.fetch(for: .species)

        // Remove the category-level entry; the top-level cache must still serve the result
        SwapiSpeciesRepository.shared.cache.removeValue(forKey: request)
        let cached = repository.cache.value(forKey: .species)
        #expect(cached?.first?.name == "Hutt")

        let results = try await repository.fetch(for: .species)
        #expect(results.first?.name == "Hutt")
    }

}

@Suite("SwapiCache key tracking Tests")
struct SwapiCacheKeyTrackingTests {

    @Test("Removed values are not encoded")
    func removedValuesAreNotEncoded() throws {
        let cache = SwapiCache<String, Int>()
        cache.insert(1, forKey: "a")
        cache.insert(2, forKey: "b")
        cache.removeValue(forKey: "a")

        let data = try JSONEncoder().encode(cache)
        let decoded = try JSONDecoder().decode([[String: AnyDecodable]].self, from: data)
        #expect(decoded.count == 1)
    }

    @Test("Custom entry lifetime is honored")
    func customEntryLifetime() {
        var simulatedTime = Date(timeIntervalSinceReferenceDate: 0)
        let cache = SwapiCache<String, Int>(dateProvider: { simulatedTime }, entryLifetime: 10)
        cache.insert(1, forKey: "k")

        simulatedTime = simulatedTime.addingTimeInterval(11)
        #expect(cache.value(forKey: "k") == nil)
    }
}

private struct AnyDecodable: Decodable {
    init(from decoder: any Decoder) throws {}
}
