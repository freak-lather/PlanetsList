
import Foundation

public enum PlanetsListApi {
    case list
}

extension PlanetsListApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://swapi.dev/api/"
        case .qa: return ""
        case .staging: return ""
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .list:
            return "planets/"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .list:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


