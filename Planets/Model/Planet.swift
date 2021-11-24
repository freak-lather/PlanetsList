import Foundation
struct PlanetsApiResponse: Codable {
    let next: String?
    let numberOfResults: Int
    let planets: [Planet]
}

extension PlanetsApiResponse {
    
    private enum PlanetsApiResponseCodingKeys: String, CodingKey {
        case next
        case numberOfResults = "count"
        case planets = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PlanetsApiResponseCodingKeys.self)
        
        next = try container.decode(String.self, forKey: .next)
        numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
        planets = try container.decode([Planet].self, forKey: .planets)
        
    }
}


struct Planet: Codable {
    let name: String
    let climate: String
    let gravity: String
    let residents: [String]
}

extension Planet {
    
    enum PlanetCodingKeys: String, CodingKey {
        case name
        case climate
        case gravity
        case residents
    }
    
    
    init(from decoder: Decoder) throws {
        let planetContainer = try decoder.container(keyedBy: PlanetCodingKeys.self)
        
        name = try planetContainer.decode(String.self, forKey: .name)
        climate = try planetContainer.decode(String.self, forKey: .climate)
        gravity = try planetContainer.decode(String.self, forKey: .gravity)
        residents = try planetContainer.decode([String].self, forKey: .residents)
    }
}
