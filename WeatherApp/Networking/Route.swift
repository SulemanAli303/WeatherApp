//
//  Route.swift
//  WeatherApp
//
//  Created by Suleman Ali on 25/10/2022.
//

import Foundation

enum Route {
    static let serverUrl = "https://weather.visualcrossing.com"
    static let baseURL = serverUrl + "/VisualCrossingWebServices/rest/services/"
    static let ApiKey = "HXCNQ9P47U2627D24WANXJMZL"
    case timeline(loc:String)
    var description: String {
        switch self {
            case .timeline(loc: let loc):
                return  Route.baseURL + "timeline/" + loc + "/last30days?key=" + Route.ApiKey + "&include=days&elements=temp,windspeed"
        }
    }
}
