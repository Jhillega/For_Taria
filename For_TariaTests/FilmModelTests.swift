import Testing
import Foundation
@testable import For_Taria

@Suite("Film Model Tests")
struct FilmModelTests {

    let filmJSON = """
    {
        "title": "A New Hope",
        "episode_id": 4,
        "opening_crawl": "It is a period of civil war.",
        "director": "George Lucas",
        "producer": "Gary Kurtz, Rick McCallum",
        "release_date": "1977-05-25",
        "characters": ["https://swapi.py4e.com/api/people/1/"],
        "planets": ["https://swapi.py4e.com/api/planets/1/"],
        "starships": ["https://swapi.py4e.com/api/starships/2/"],
        "vehicles": ["https://swapi.py4e.com/api/vehicles/4/"],
        "species": ["https://swapi.py4e.com/api/species/1/"],
        "created": "2014-12-10T14:23:31.880000Z",
        "edited": "2014-12-20T19:49:45.256000Z",
        "url": "https://swapi.py4e.com/api/films/1/"
    }
    """.data(using: .utf8)!

    @Test("Film decodes from JSON correctly")
    func filmDecodesFromJSON() throws {
        let film = try JSONDecoder().decode(Film.self, from: filmJSON)
        #expect(film.name == "A New Hope")
        #expect(film.director == "George Lucas")
        #expect(film.producer == "Gary Kurtz, Rick McCallum")
        #expect(film.url == "https://swapi.py4e.com/api/films/1/")
    }

    @Test("title maps to name and snake case keys decode")
    func snakeCaseKeysDecodeCorrectly() throws {
        let film = try JSONDecoder().decode(Film.self, from: filmJSON)
        #expect(film.episodeID == 4)
        #expect(film.openingCrawl == "It is a period of civil war.")
        #expect(film.releaseDate == "1977-05-25")
    }

    @Test("Related resource arrays decode")
    func relatedArraysDecode() throws {
        let film = try JSONDecoder().decode(Film.self, from: filmJSON)
        #expect(film.characters.count == 1)
        #expect(film.planets.count == 1)
        #expect(film.starships.count == 1)
        #expect(film.vehicles.count == 1)
        #expect(film.species.count == 1)
    }

    @Test("Encoding writes title rather than name")
    func encodingUsesTitleKey() throws {
        let film = try JSONDecoder().decode(Film.self, from: filmJSON)
        let data = try JSONEncoder().encode(film)
        let object = try #require(try JSONSerialization.jsonObject(with: data) as? [String: Any])
        #expect(object["title"] as? String == "A New Hope")
        #expect(object["name"] == nil)
    }

    @Test("Missing required key throws")
    func missingKeyThrows() {
        let json = #"{"title": "Incomplete"}"#.data(using: .utf8)!
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(Film.self, from: json)
        }
    }

    @Test("SwapiFilmResults decodes count and results")
    func swapiFilmResultsDecodes() throws {
        let json = """
        { "count": 6, "next": null, "previous": null, "results": [] }
        """.data(using: .utf8)!
        let results = try JSONDecoder().decode(SwapiFilmResults.self, from: json)
        #expect(results.count == 6)
        #expect(results.results?.isEmpty == true)
    }
}
