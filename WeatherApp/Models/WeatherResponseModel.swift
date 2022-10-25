//
//  WeatherResponseModel.swift
//  WeatherApp
//
//  Created by Suleman Ali on 25/10/2022.
//

import Foundation
    // MARK: - WeatherResponseModel
class WeatherResponseModel:Codable {
    var days: [Day] = []
    var resolvedAddress: String
    var address: String
    
    enum CodingKeys: String, CodingKey {
        case days = "days"
        case resolvedAddress = "resolvedAddress"
        case address = "address"
    }
    
    
    var getAverageTemp:Double {
        let sum = days.reduce(0){ $0 + $1.temp }
        return sum/Double(days.count)
    }
    var getAverageWindSpeed:Double {
        let sum = days.reduce(0){ $0 + $1.windspeed }
        return sum/Double(days.count)
    }
    var getMedianTemp:Double {
        let SortedDays =  days.sorted{$0.temp < $1.temp}
        let count = SortedDays.count
        if count % 2 != 0 {
            return Double(SortedDays[count/2].temp)
        } else {
            return Double(SortedDays[count/2].temp + SortedDays[count/2 - 1].temp) / 2.0
        }
    }
    var getMedianWind:Double {
        let SortedDays =  days.sorted{$0.windspeed < $1.windspeed}
        let count = SortedDays.count
        if count % 2 != 0 {
            return Double(SortedDays[count/2].windspeed)
        } else {
            return Double(SortedDays[count/2].windspeed + SortedDays[count/2 - 1].windspeed) / 2.0
        }
    }
    
   init(days: [Day],resolvedAddress: String, address: String) {
       self.days = days
       self.address = address
       self.resolvedAddress = resolvedAddress
    }
}


    // MARK: - Day
class Day:Codable {
    var temp: Double
    var windspeed: Double
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case windspeed = "windspeed"
    }
    
    
    init(temp: Double, windspeed: Double) {
        self.temp = temp
        self.windspeed = windspeed
    }
}
