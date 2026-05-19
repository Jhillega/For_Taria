import Testing
import Foundation
@testable import For_Taria

@Suite("Planet Model Tests")
struct PlanetModelTests {

    let tatooineJSON = """
    {
        "name": "Tatooine",
        "rotation_period": "23",
        "orbital_period": "304",
        "diameter": "10465",
        "climate": "arid",
        "gravity": "1 standard",
        "terrain": "desert",
        "surface_water": "1",
        "population": "200000",
        "residents": ["https://swapi.py4e.com/api/people/1/"],
        "films": ["https://swapi.py4e.com/api/films/1/"],
        "created": "2014-12-09T13:50:49.641000Z",
        "edited": "2014-12-20T20:58:18.411000Z",
        "url": "https://swapi.py4e.com/api/planets/1/"
    }
    """.data(using: .utf8)!

    @Test("Planet decodes from JSON correctly")
    func planetDecodesFromJSON() throws {
        let planet = try JSONDecoder().decode(Planet.self, from: tatooineJSON)
        #expect(planet.name == "Tatooine")
        #expect(planet.rotationPeriod == "23")
        #expect(planet.orbitalPeriod == "304")
        #expect(planet.climate == "arid")
        #expect(planet.diameter == "10465")
    }

    @Test("Snake case keys decode correctly")
    func snakeCaseKeysDecodeCorrectly() throws {
        let planet = try JSONDecoder().decode(Planet.self, from: tatooineJSON)
        #expect(planet.surfaceWater == "1")
        #expect(planet.rotationPeriod == "23")
        #expect(planet.orbitalPeriod == "304")
    }

    @Test("dataForProperty returns correct values")
    func dataForPropertyReturnsCorrectValues() throws {
        let planet = try JSONDecoder().decode(Planet.self, from: tatooineJSON)
        #expect(planet.dataForProperty(.name) == "Tatooine")
        #expect(planet.dataForProperty(.climate) == "arid")
        #expect(planet.dataForProperty(.terrain) == "desert")
        #expect(planet.dataForProperty(.population) == "200000")
        #expect(planet.dataForProperty(.url) == "https://swapi.py4e.com/api/planets/1/")
    }

    @Test("Multiple residents joined with comma")
    func residentsJoinedWithComma() throws {
        let json = """
        {
            "name": "Alderaan",
            "rotation_period": "24",
            "orbital_period": "364",
            "diameter": "12500",
            "climate": "temperate",
            "gravity": "1 standard",
            "terrain": "grasslands",
            "surface_water": "40",
            "population": "2000000000",
            "residents": ["https://swapi.py4e.com/api/people/5/", "https://swapi.py4e.com/api/people/68/"],
            "films": [],
            "created": "2014-12-10T11:35:48.479000Z",
            "edited": "2014-12-20T20:58:18.420000Z",
            "url": "https://swapi.py4e.com/api/planets/2/"
        }
        """.data(using: .utf8)!
        let planet = try JSONDecoder().decode(Planet.self, from: json)
        #expect(planet.dataForProperty(.residents).contains(","))
    }

    @Test("displayablePropertyNames returns all CodingKeys cases")
    func displayablePropertyNamesReturnsAllCases() {
        #expect(Planet.displayablePropertyNames.count == Planet.CodingKeys.allCases.count)
    }

    @Test("SwapiPlanetResults decodes count and empty results")
    func swapiPlanetResultsDecodes() throws {
        let json = """
        {
            "count": 60,
            "next": null,
            "previous": null,
            "results": []
        }
        """.data(using: .utf8)!
        let results = try JSONDecoder().decode(SwapiPlanetResults.self, from: json)
        #expect(results.count == 60)
        #expect(results.next == nil)
        #expect(results.results?.isEmpty == true)
    }
}
