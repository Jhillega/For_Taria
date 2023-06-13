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
                        hairColor: "",
                        skinColor: "",
                        eyeColor: "",
                        birthYear: "1998",
                        gender: .male,
                        homeworld: "",
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
    static let film = Film(title: "Mandolore in Test",
                    episodeID: 0,
                    openingCrawl: "Nothing yet",
                    director: "Poppy June Thomas",
                    producer: "Taria Thomas",
                    releaseDate: "March 19, 2023",
                    characters: [""],
                    planets: [""],
                    starships: [""],
                    vehicles: [""],
                    species: [""],
                    created: "",
                    edited: "",
                    url: "")
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
