//
//  WeatherEndPoints.swift
//  WeatherApp
//
//  Created by Suleman Ali on 25/10/2022.
//

import Foundation


enum NetworkEnvironment {
    case local
    case production
    case staging
}

public enum WeatherEndPoint {
    case weather(loc:String)

}

extension WeatherEndPoint: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/"
        case .local: return "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/"
        case .staging: return "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
            case .weather(loc: let loc ):
                return "timeline/" + loc + "/last30days"
          
                
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .weather(loc: _ ):
                return  .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["key":NetworkManager.apiKey, "include":"days","elements":"temp,windspeed"])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


