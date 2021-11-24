import Foundation
enum PersistenceStoreError: Error {
    case encodingError
    case decodingError
}
protocol PersistenceStoreProtocol {
    func storeDataIn(userDefaults planets: [Planet]) throws
    func retrieveDataFromUserDefaults() throws -> [Planet]?
}
/**
     This class is used for supporting offline mode of app. I used UserDefaults because data we are showing is very small size.
      Some other ways for better approach are CoreData, Property list, Realm, SQLite, FIles
       
 */
class PlanetsLocalPersistentStore: PersistenceStoreProtocol {
    
    static let shared = PlanetsLocalPersistentStore()
    
    func storeDataIn(userDefaults planets: [Planet]) throws {
        do {
            let data = try JSONEncoder().encode(planets)
            UserDefaults.standard.set(data, forKey: "planets")
            
        } catch {
            throw PersistenceStoreError.encodingError
        }
    }
    
    func retrieveDataFromUserDefaults() throws -> [Planet]? {
        guard let data = UserDefaults.standard.data(forKey: "planets") else { return nil }
        do {
            let planets = try JSONDecoder().decode([Planet].self, from: data)
            return planets
            
        } catch {
            print(error)
            throw PersistenceStoreError.decodingError
        }
    }
}
