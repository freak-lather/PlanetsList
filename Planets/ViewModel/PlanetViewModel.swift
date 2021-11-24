import Foundation
class PlanetViewModel {
    private let networkManager: NetworkManagerProtocol?
    var reloadTable: (() -> Void)?
    var planets: [Planet]? {
        didSet {
            if reloadTable != nil {
                reloadTable!()
            }
        }
    }
    
    init(networkManager: NetworkManagerProtocol? = NetworkManager()) {
        self.networkManager = networkManager
    }
    func getPlanetsList() {
        let localStore = PlanetsLocalPersistentStore.shared
        self.networkManager?.getPlanets(completion: { [weak self] (planets, error) in
            guard let planets = planets else { return }
            do {
                try localStore.storeDataIn(userDefaults: planets)
                let planets = try localStore.retrieveDataFromUserDefaults()
                self?.planets = planets
            } catch {
                debugPrint(error)
            }
        })
    }
    func getNumberOfRows() -> Int {
        return self.planets?.count ?? 0
    }
    func getPlanet(for index: Int) -> Planet? {
        guard let planets = planets else { return nil }
        return planets[index]
    }
    func getTitle() -> String {
        return "Planets"
    }
}
