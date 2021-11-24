import Foundation
@testable import Planets
class NetworkManagerMock: NetworkManagerProtocol {
    private var result: Result<String>
    init(result: Result<String>) {
        self.result = result
    }
    func getPlanets(completion: @escaping ([Planet]?, String?) -> ()) {
        switch self.result {
        case .success:
            let planet1 = Planet(name: "Jupiter", climate: "foggy", gravity: "highest", residents: ["www.google.com", "www.facebook.com"])
            let planet2 = Planet(name: "Mars", climate: "clear", gravity: "lowest", residents: ["www.flickr.com", "www.facebook.com"])
            let planets = [planet1, planet2]
            
            completion(planets, nil)
        case .failure(let error):
            completion(nil, error)
        }
    }
}
