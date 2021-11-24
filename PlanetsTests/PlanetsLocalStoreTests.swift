import XCTest
@testable import Planets
class PlanetsLocalStoreTests: XCTestCase {
    let persistenceStore = PlanetsLocalPersistentStore.shared
    func testStoreDataSuccess() {
        let p1 = Planet(name: "Jupiter", climate: "humid", gravity: "high", residents: ["www.google.com"])
        let p2 = Planet(name: "Mars", climate: "dry", gravity: "low", residents: ["www.facebook.com"])
        do {
            try persistenceStore.storeDataIn(userDefaults: [p1, p2])
            let planets = try persistenceStore.retrieveDataFromUserDefaults()
            XCTAssertNotNil(planets)
        } catch {
            XCTAssertNotNil(error)
        }
        
        
    }
    func testStoreDataFails() {
        do {
            try persistenceStore.storeDataIn(userDefaults: [])
            guard let planets = try persistenceStore.retrieveDataFromUserDefaults() else { return }
            XCTAssertTrue(planets.count == 0)
        } catch {
            XCTAssertNotNil(error)
        }
        
    }
}
