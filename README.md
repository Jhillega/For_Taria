# For Taria

A Star Wars encyclopedia app for iOS, built with SwiftUI. Browse characters, planets, starships, vehicles, films, and species from the [SWAPI](https://swapi.py4e.com) API — with visual effects and offline caching. Started as a fun project for my wife and became a pet portfolio project. Always open to suggestions.

## Features

- Browse all six SWAPI categories: People, Planets, Starships, Vehicles, Films, Species
- Search across categories in real time
- TTL-based in-memory caching to reduce redundant network requests
- Custom Metal shaders, particle effects, dissolve transitions, and a crawling saga text scroll
- Opening crawl viewer for each film

## Requirements

- iOS 18.0+
- Xcode 16+
- Swift 5.0+
- Active internet connection for first load (results are cached afterward)

## Architecture

The app follows a repository pattern layered over a protocol-based service:

```
Views  →  Repositories  →  SWAPIService (protocol)  →  SwapiHTTPClient
                ↓
           SwapiCache<URLRequest, [Model]>
```

**Key components:**

| Layer | Files |
|---|---|
| Network | `SwapiHTTPClient`, `SWAPIService`, `SwapiEndpoints` |
| Caching | `SwapiCache<Key, Value>` with configurable TTL |
| Repositories | `SwapiPlanetRepository`, `SWAPIPeopleRepository`, etc. |
| Models | `Planet`, `Person`, `Starship`, `Vehicle`, `Film`, `Species` |
| Mock | `MockService` / `MockServiceManager` for previews |

All models conform to `Codable` and `SWAPISearchResultPresentable`, which drives the unified search results view.

## Project Structure

```
For_Taria/
├── Managers/
│   ├── Caching/          SwapiCache, AppError
│   ├── Network/          SWAPIService, SwapiHTTPClient, SwapiEndpoints
│   └── MockServiceManager/
├── Models/
│   ├── Person/  Planet/  Starship/  Vehicle/  Film/  Species/
│   └── UIFormattingData.swift   (preview & formatting data)
├── Views/
│   ├── MenuAndTitle/     ContentView, TitleView, CategoryView, MainView
│   ├── Effects/          Metal shaders, particle effects, transitions
│   └── [Category]/       List and detail views per category
For_TariaTests/
│   ├── SwapiCacheTests.swift
│   ├── PlanetModelTests.swift
│   ├── PersonModelTests.swift
│   └── SwapiEndpointTests.swift
```

## Running the App

1. Clone the repo and open `For_Taria.xcodeproj`
2. Select a simulator or device running iOS 18+
3. Build and run (`⌘R`)

No API key or additional setup required.

## Running Tests

Select the **For_TariaTests** scheme and run (`⌘U`). Tests use the Swift Testing framework and cover:

- `SwapiCache` — insert/retrieve, TTL expiry, subscript, multi-key isolation
- `Planet` model — JSON decoding, snake_case keys, `dataForProperty`, display names
- `Person` model — JSON decoding, all `Gender` enum variants, snake_case keys
- `SwapiCategoryEndpoints` — paths, full URLs, search URL construction, cache times
