import Testing
@testable import For_Taria

@Suite("SWAPI Endpoint Tests")
struct SwapiEndpointTests {

    @Test("All endpoints share the same base URL")
    func allEndpointsHaveCorrectBaseURL() {
        let expected = "https://swapi.py4e.com/api/"
        for endpoint in SwapiCategoryEndpoints.allCases {
            #expect(endpoint.baseURL == expected)
        }
    }

    @Test("Each endpoint has the correct path")
    func endpointPathsAreCorrect() {
        #expect(SwapiCategoryEndpoints.people.path == "people/")
        #expect(SwapiCategoryEndpoints.planets.path == "planets/")
        #expect(SwapiCategoryEndpoints.vehicles.path == "vehicles/")
        #expect(SwapiCategoryEndpoints.starships.path == "starships/")
        #expect(SwapiCategoryEndpoints.films.path == "films/")
        #expect(SwapiCategoryEndpoints.species.path == "species/")
    }

    @Test("categoryfullURL concatenates base and path")
    func fullURLCombinesBaseAndPath() {
        #expect(SwapiCategoryEndpoints.planets.categoryfullURL == "https://swapi.py4e.com/api/planets/")
        #expect(SwapiCategoryEndpoints.people.categoryfullURL == "https://swapi.py4e.com/api/people/")
    }

    @Test("Search URL appends query parameter correctly")
    func searchURLAppendsQuery() {
        let url = SwapiCategoryEndpoints.people.createSearchURLString(with: "Luke")
        #expect(url == "https://swapi.py4e.com/api/people/?search=Luke")
    }

    @Test("Cache time is positive for every endpoint")
    func cacheTimeIsPositive() {
        for endpoint in SwapiCategoryEndpoints.allCases {
            #expect(endpoint.cacheTime > 0)
        }
    }
}
