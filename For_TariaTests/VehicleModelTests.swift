import Testing
import Foundation
@testable import For_Taria

@Suite("Vehicle Model Tests")
struct VehicleModelTests {

    let vehicleJSON = """
    {
        "name": "Sand Crawler",
        "model": "Digger Crawler",
        "manufacturer": "Corellia Mining Corporation",
        "cost_in_credits": "150000",
        "length": "36.8",
        "max_atmosphering_speed": "30",
        "crew": "46",
        "passengers": "30",
        "cargo_capacity": "50000",
        "consumables": "2 months",
        "vehicle_class": "wheeled",
        "pilots": [],
        "films": ["https://swapi.py4e.com/api/films/1/"],
        "created": "2014-12-10T15:36:25.724000Z",
        "edited": "2014-12-20T21:30:21.661000Z",
        "url": "https://swapi.py4e.com/api/vehicles/4/"
    }
    """.data(using: .utf8)!

    @Test("Vehicle decodes from JSON correctly")
    func vehicleDecodesFromJSON() throws {
        let vehicle = try JSONDecoder().decode(Vehicle.self, from: vehicleJSON)
        #expect(vehicle.name == "Sand Crawler")
        #expect(vehicle.model == "Digger Crawler")
        #expect(vehicle.manufacturer == "Corellia Mining Corporation")
        #expect(vehicle.length == "36.8")
        #expect(vehicle.crew == "46")
        #expect(vehicle.passengers == "30")
    }

    @Test("Snake case keys decode correctly")
    func snakeCaseKeysDecodeCorrectly() throws {
        let vehicle = try JSONDecoder().decode(Vehicle.self, from: vehicleJSON)
        #expect(vehicle.costInCredits == "150000")
        #expect(vehicle.maxAtmospheringSpeed == "30")
        #expect(vehicle.cargoCapacity == "50000")
        #expect(vehicle.vehicleClass == "wheeled")
    }

    @Test("Empty pilots and populated films decode")
    func relatedArraysDecode() throws {
        let vehicle = try JSONDecoder().decode(Vehicle.self, from: vehicleJSON)
        #expect(vehicle.pilots.isEmpty)
        #expect(vehicle.films.count == 1)
    }

    @Test("Encode then decode round trips")
    func roundTrips() throws {
        let original = try JSONDecoder().decode(Vehicle.self, from: vehicleJSON)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(Vehicle.self, from: data)
        #expect(decoded.name == original.name)
        #expect(decoded.vehicleClass == original.vehicleClass)
        #expect(decoded.url == original.url)
    }

    @Test("Missing required key throws")
    func missingKeyThrows() {
        let json = #"{"name": "Incomplete"}"#.data(using: .utf8)!
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(Vehicle.self, from: json)
        }
    }

    @Test("SwapiVehicleResults decodes count and empty results")
    func swapiVehicleResultsDecodes() throws {
        let json = """
        { "count": 39, "next": null, "previous": null, "results": [] }
        """.data(using: .utf8)!
        let results = try JSONDecoder().decode(SwapiVehicleResults.self, from: json)
        #expect(results.count == 39)
        #expect(results.next == nil)
        #expect(results.results?.isEmpty == true)
    }
}
