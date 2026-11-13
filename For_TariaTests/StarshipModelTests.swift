import Testing
import Foundation
@testable import For_Taria

@Suite("Starship Model Tests")
struct StarshipModelTests {

    let starshipJSON = """
    {
        "name": "Millennium Falcon",
        "model": "YT-1300 light freighter",
        "manufacturer": "Corellian Engineering Corporation",
        "cost_in_credits": "100000",
        "length": "34.37",
        "max_atmosphering_speed": "1050",
        "crew": "4",
        "passengers": "6",
        "cargo_capacity": "100000",
        "consumables": "2 months",
        "hyperdrive_rating": "0.5",
        "MGLT": "75",
        "starship_class": "Light freighter",
        "pilots": ["https://swapi.py4e.com/api/people/13/", "https://swapi.py4e.com/api/people/14/"],
        "films": ["https://swapi.py4e.com/api/films/1/"],
        "created": "2014-12-10T16:59:45.094000Z",
        "edited": "2014-12-20T21:23:49.880000Z",
        "url": "https://swapi.py4e.com/api/starships/10/"
    }
    """.data(using: .utf8)!

    @Test("Starship decodes from JSON correctly")
    func starshipDecodesFromJSON() throws {
        let ship = try JSONDecoder().decode(Starship.self, from: starshipJSON)
        #expect(ship.name == "Millennium Falcon")
        #expect(ship.model == "YT-1300 light freighter")
        #expect(ship.manufacturer == "Corellian Engineering Corporation")
        #expect(ship.length == "34.37")
        #expect(ship.crew == "4")
        #expect(ship.passengers == "6")
    }

    @Test("Snake case keys decode correctly")
    func snakeCaseKeysDecodeCorrectly() throws {
        let ship = try JSONDecoder().decode(Starship.self, from: starshipJSON)
        #expect(ship.costInCredits == "100000")
        #expect(ship.maxAtmospheringSpeed == "1050")
        #expect(ship.cargoCapacity == "100000")
        #expect(ship.hyperdriveRating == "0.5")
        #expect(ship.starshipClass == "Light freighter")
    }

    @Test("Uppercase MGLT key maps to mglt")
    func mgltKeyDecodes() throws {
        let ship = try JSONDecoder().decode(Starship.self, from: starshipJSON)
        #expect(ship.mglt == "75")
    }

    @Test("Pilots and films arrays decode")
    func relatedArraysDecode() throws {
        let ship = try JSONDecoder().decode(Starship.self, from: starshipJSON)
        #expect(ship.pilots.count == 2)
        #expect(ship.films.count == 1)
    }

    @Test("Encoding writes MGLT key")
    func encodingUsesMGLTKey() throws {
        let ship = try JSONDecoder().decode(Starship.self, from: starshipJSON)
        let data = try JSONEncoder().encode(ship)
        let object = try #require(try JSONSerialization.jsonObject(with: data) as? [String: Any])
        #expect(object["MGLT"] as? String == "75")
    }

    @Test("Missing required key throws")
    func missingKeyThrows() {
        let json = #"{"name": "Incomplete"}"#.data(using: .utf8)!
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(Starship.self, from: json)
        }
    }

    @Test("SwapiStarshipResults decodes count and empty results")
    func swapiStarshipResultsDecodes() throws {
        let json = """
        { "count": 36, "next": null, "previous": null, "results": [] }
        """.data(using: .utf8)!
        let results = try JSONDecoder().decode(SwapiStarshipResults.self, from: json)
        #expect(results.count == 36)
        #expect(results.next == nil)
        #expect(results.results?.isEmpty == true)
    }
}
