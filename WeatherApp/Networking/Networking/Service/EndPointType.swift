//
//  EndPoint.swift
//  WeatherApp
//
//  Created by Suleman Ali on 25/10/2022.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

