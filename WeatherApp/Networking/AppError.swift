//
//  AppError.swift
//  WeatherApp
//
//  Created by Suleman Ali on 25/10/2022.
//

import Foundation

enum AppError: LocalizedError {
    case errorDecoding
    case unknownError
    case invalidUrl
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Response could not be decoded"
        case .unknownError:
            return "Unknown Error Occurs on Mobile Side Contact to Admin"
        case .invalidUrl:
            return "invalid Url Given Contact to Admin"
        case .serverError(let error):
            return error
        }
    }
}
