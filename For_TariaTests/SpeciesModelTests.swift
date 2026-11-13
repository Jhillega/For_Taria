import Testing
import Foundation
@testable import For_Taria

@Suite("Species Model Tests")
struct SpeciesModelTests {

    func speciesJSON(designation: String = "sentient", homeworld: String = "\"https://swapi.py4e.com/api/planets/8/\"") -> Data {
        """
        {
            "name": "Human",
            "classification": "mammal",
            "designation": "\(designation)",
            "average_height": "180",
            "skin_colors": "caucasian, black, asian",
            "hair_colors": "blonde, brown, black, red",
            "eye_colors": "brown, blue, green, hazel, grey, amber",
            "average_lifespan": "120",
            "homeworld": \(homeworld),
            "language": "Galactic Basic",
            "people": ["https://swapi.py4e.com/api/people/66/"],
            "films": ["https://swapi.py4e.com/api/films/1/", "https://swapi.py4e.com/api/films/2/"],
            "created": "2014-12-10T13:52:11.567000Z",
            "edited": "2014-12-20T21:36:42.136000Z",
            "url": "https://swapi.py4e.com/api/species/1/"
        }
        """.data(using: .utf8)!
    }

    @Test("Species decodes from JSON correctly")
    func speciesDecodesFromJSON() throws {
        let species = try JSONDecoder().decode(Species.self, from: speciesJSON())
        #expect(species.name == "Human")
        #expect(species.classification == "mammal")
        #expect(species.language == "Galactic Basic")
        #expect(species.designation == .sentient)
    }

    @Test("Snake case keys decode correctly")
    func snakeCaseKeysDecodeCorrectly() throws {
        let species = try JSONDecoder().decode(Species.self, from: speciesJSON())
        #expect(species.averageHeight == "180")
        #expect(species.skinColors == "caucasian, black, asian")
        #expect(species.hairColors == "blonde, brown, black, red")
        #expect(species.eyeColors.contains("hazel"))
        #expect(species.averageLifespan == "120")
    }

    @Test("Reptilian designation decodes")
    func reptilianDesignationDecodes() throws {
        let species = try JSONDecoder().decode(Species.self, from: speciesJSON(designation: "reptilian"))
        #expect(species.designation == .reptilian)
    }

    @Test("Unknown designation throws")
    func unknownDesignationThrows() {
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(Species.self, from: speciesJSON(designation: "mystical"))
        }
    }

    @Test("Null homeworld decodes as nil")
    func nullHomeworldDecodesAsNil() throws {
        let species = try JSONDecoder().decode(Species.self, from: speciesJSON(homeworld: "null"))
        #expect(species.homeworld == nil)
    }

    @Test("Related arrays decode")
    func relatedArraysDecode() throws {
        let species = try JSONDecoder().decode(Species.self, from: speciesJSON())
        #expect(species.people.count == 1)
        #expect(species.films.count == 2)
    }

    @Test("Encode then decode round trips")
    func roundTrips() throws {
        let original = try JSONDecoder().decode(Species.self, from: speciesJSON())
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(Species.self, from: data)
        #expect(decoded.name == original.name)
        #expect(decoded.designation == original.designation)
        #expect(decoded.url == original.url)
    }

    @Test("SwapiSpeciesResults decodes next page and empty results")
    func swapiSpeciesResultsDecodes() throws {
        let json = """
        { "count": 37, "next": "https://swapi.py4e.com/api/species/?page=2", "previous": null, "results": [] }
        """.data(using: .utf8)!
        let results = try JSONDecoder().decode(SwapiSpeciesResults.self, from: json)
        #expect(results.count == 37)
        #expect(results.next == "https://swapi.py4e.com/api/species/?page=2")
        #expect(results.results?.isEmpty == true)
    }
}
