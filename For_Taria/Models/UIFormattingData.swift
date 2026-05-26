//
//  UIFormattingData.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/12/23.
//

import Foundation

struct SwapiFormattingData {
    //MARK: person
    static let person = Person(name: "Dash Rendar",
                        height: "66",
                        mass: "55",
                        hairColor: "Brown",
                        skinColor: "Fair",
                        eyeColor: "Blue",
                        birthYear: "1998",
                        gender: .male,
                        homeworld: "Earth",
                        films: [],
                        species: [],
                        vehicles: [],
                        starships: [],
                        created: "",
                        edited: "",
                        url: "")
    //MARK: planet
    static let planet = Planet(name: "Earth",
                        rotationPeriod: "24 hours",
                        orbitalPeriod: "365 Days",
                        diameter: "",
                        climate: "temperate",
                        gravity: "-9.86",
                        terrain: "Gaia",
                        surfaceWater: "Awesome",
                        population: "9 billion",
                        residents: [],
                        films: [],
                        created: "",
                        edited: "",
                        url: "")
    //MARK: film
    static let film = Film(name: "A New Hope",
                    episodeID: 4,
                    openingCrawl: "It is a period of civil war.\r\nRebel spaceships, striking\r\nfrom a hidden base, have won\r\ntheir first victory against\r\nthe evil Galactic Empire.\r\n\r\nDuring the battle, Rebel\r\nspies managed to steal secret\r\nplans to the Empire's\r\nultimate weapon, the DEATH\r\nSTAR, an armored space\r\nstation with enough power\r\nto destroy an entire planet.\r\n\r\nPursued by the Empire's\r\nsinister agents, Princess\r\nLeia races home aboard her\r\nstarship, custodian of the\r\nstolen plans that can save her\r\npeople and restore\r\nfreedom to the galaxy....",
                    director: "George Lucas",
                    producer: "Gary Kurtz, Rick McCallum",
                    releaseDate: "1977-05-25",
                    characters: [
                        "https://swapi.py4e.com/api/people/1/",
                        "https://swapi.py4e.com/api/people/2/",
                        "https://swapi.py4e.com/api/people/3/",
                        "https://swapi.py4e.com/api/people/4/",
                        "https://swapi.py4e.com/api/people/5/",
                        "https://swapi.py4e.com/api/people/6/",
                        "https://swapi.py4e.com/api/people/7/",
                        "https://swapi.py4e.com/api/people/8/",
                        "https://swapi.py4e.com/api/people/9/",
                        "https://swapi.py4e.com/api/people/10/",
                        "https://swapi.py4e.com/api/people/12/",
                        "https://swapi.py4e.com/api/people/13/",
                        "https://swapi.py4e.com/api/people/14/",
                        "https://swapi.py4e.com/api/people/15/",
                        "https://swapi.py4e.com/api/people/16/",
                        "https://swapi.py4e.com/api/people/18/",
                        "https://swapi.py4e.com/api/people/19/",
                        "https://swapi.py4e.com/api/people/81/"
                    ],
                    planets: [
                        "https://swapi.py4e.com/api/planets/1/",
                        "https://swapi.py4e.com/api/planets/2/",
                        "https://swapi.py4e.com/api/planets/3/"
                    ],
                    starships: [
                        "https://swapi.py4e.com/api/starships/2/",
                        "https://swapi.py4e.com/api/starships/3/",
                        "https://swapi.py4e.com/api/starships/5/",
                        "https://swapi.py4e.com/api/starships/9/",
                        "https://swapi.py4e.com/api/starships/10/",
                        "https://swapi.py4e.com/api/starships/11/",
                        "https://swapi.py4e.com/api/starships/12/",
                        "https://swapi.py4e.com/api/starships/13/"
                    ],
                    vehicles: [
                        "https://swapi.py4e.com/api/vehicles/4/",
                        "https://swapi.py4e.com/api/vehicles/6/",
                        "https://swapi.py4e.com/api/vehicles/7/",
                        "https://swapi.py4e.com/api/vehicles/8/"
                    ],
                    species: [
                        "https://swapi.py4e.com/api/species/1/",
                        "https://swapi.py4e.com/api/species/2/",
                        "https://swapi.py4e.com/api/species/3/",
                        "https://swapi.py4e.com/api/species/4/",
                        "https://swapi.py4e.com/api/species/5/"
                    ],
                    created: "2014-12-10T14:23:31.880000Z",
                    edited: "2014-12-20T19:49:45.256000Z",
                    url: "https://swapi.py4e.com/api/films/1/")
    //MARK: vehicle
    static let vehicle = Vehicle(name: "Test",
                          model: "Test",
                          manufacturer: "test",
                          costInCredits: "Test",
                          length: "",
                          maxAtmospheringSpeed: "",
                          crew: "",
                          passengers: "",
                          cargoCapacity: "",
                          consumables: "",
                          vehicleClass: "",
                          pilots: [""],
                          films: [""],
                          created: "",
                          edited: "",
                          url: "")
    //MARK: species
    static let species = Species(name: "Kerek",
                          classification: "Biped",
                          designation: .reptilian,
                          averageHeight: "",
                          skinColors: "",
                          hairColors: "",
                          eyeColors: "",
                          averageLifespan: "",
                          homeworld: "None of your business",
                          language: "BO'stik",
                          people: [""],
                          films: [""],
                          created: "",
                          edited: "",
                          url: "")
    //MARK: starships
    static let starship = Starship(name: "Test Ship",
                            model: "Testy Testerson",
                            manufacturer: "Me",
                            costInCredits: "5600000",
                            length: "120",
                            maxAtmospheringSpeed: "664",
                            crew: "Awesome",
                            passengers: "0",
                            cargoCapacity: "0",
                            consumables: "0",
                            hyperdriveRating: "0",
                            mglt: "0",
                            starshipClass: "Test Fleet Ship",
                            pilots: [""],
                            films: [""],
                            created: "",
                            edited: "",
                            url: "")
    
}
