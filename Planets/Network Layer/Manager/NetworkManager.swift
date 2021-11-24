
import Foundation

protocol NetworkManagerProtocol {
    func getPlanets(completion: @escaping (_ planets: [Planet]?,_ error: String?)->())
}

struct NetworkManager: NetworkManagerProtocol {
    static let environment : NetworkEnvironment = .production
    let router = Router<PlanetsListApi>()
    
    func getPlanets(completion: @escaping (_ planets: [Planet]?,_ error: String?)->()){
        router.request(.list) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(PlanetsApiResponse.self, from: responseData)
                        completion(apiResponse.planets, nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
