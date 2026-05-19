import Testing
import SwiftUI
import Foundation
@testable import For_Taria

@Suite("Person Model Tests")
struct PersonModelTests {

    func makePersonJSON(gender: String) -> Data {
        """
        {
            "name": "Luke Skywalker",
            "height": "172",
            "mass": "77",
            "hair_color": "blond",
            "skin_color": "fair",
            "eye_color": "blue",
            "birth_year": "19BBY",
            "gender": "\(gender)",
            "homeworld": "https://swapi.py4e.com/api/planets/1/",
            "films": [],
            "species": [],
            "vehicles": [],
            "starships": [],
            "created": "2014-12-09T13:50:51.644000Z",
            "edited": "2014-12-20T21:17:56.891000Z",
            "url": "https://swapi.py4e.com/api/people/1/"
        }
        """.data(using: .utf8)!
    }

    @Test("Person decodes name and basic fields")
    func personDecodesFromJSON() throws {
        let person = try JSONDecoder().decode(Person.self, from: makePersonJSON(gender: "male"))
        #expect(person.name == "Luke Skywalker")
        #expect(person.height == "172")
        #expect(person.mass == "77")
        #expect(person.birthYear == "19BBY")
    }

    @Test("Snake case keys decode to camelCase properties")
    func snakeCaseKeysDecodeToCamelCase() throws {
        let person = try JSONDecoder().decode(Person.self, from: makePersonJSON(gender: "male"))
        #expect(person.hairColor == "blond")
        #expect(person.skinColor == "fair")
        #expect(person.eyeColor == "blue")
    }

    @Test("Gender decodes as male")
    func genderDecodesAsMale() throws {
        let person = try JSONDecoder().decode(Person.self, from: makePersonJSON(gender: "male"))
        #expect(person.gender == .male)
    }

    @Test("Gender decodes as female")
    func genderDecodesAsFemale() throws {
        let person = try JSONDecoder().decode(Person.self, from: makePersonJSON(gender: "female"))
        #expect(person.gender == .female)
    }

    @Test("Gender decodes n/a")
    func genderDecodesNA() throws {
        let person = try JSONDecoder().decode(Person.self, from: makePersonJSON(gender: "n/a"))
        #expect(person.gender == .nA)
    }

    @Test("SwapiPeopleResults decodes count and next page URL")
    func swapiPeopleResultsDecodes() throws {
        let json = """
        {
            "count": 82,
            "next": "https://swapi.py4e.com/api/people/?page=2",
            "previous": null,
            "results": []
        }
        """.data(using: .utf8)!
        let results = try JSONDecoder().decode(SwapiPeopleResults.self, from: json)
        #expect(results.count == 82)
        #expect(results.next != nil)
        #expect(results.results?.isEmpty == true)
    }
}
