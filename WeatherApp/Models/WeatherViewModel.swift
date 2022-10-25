//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Suleman Ali on 25/10/2022.
//

import Foundation
class WeatherViewModel {
   
    var weatherArr:[WeatherResponseModel] = []
    @Published var errorMessage:String?
    @Published var isShowProgress:Bool = false
    @Published var isReloadNeed:Bool = false
    let group = DispatchGroup()
    func getAllWeathers(){
        self.isShowProgress = true
        
        getWeather(locationName: Locations.Islamabad.rawValue)
        getWeather(locationName: Locations.Lodz.rawValue)
        getWeather(locationName: Locations.Brussels.rawValue)
        getWeather(locationName: Locations.Copenhagen.rawValue)
        getWeather(locationName: LocationService.shared.currentCity)
        
        group.notify(queue: .main) {
            self.isShowProgress = false
            self.isReloadNeed = true
        }
        
        
        
        
    }
    
    private func getWeather(locationName:String){
        
        group.enter()
        NetworkService.shared.getTimeline(locationName: locationName,completion: {
            [weak self]result in
            self?.group.leave()
            switch result {
                case .success(let success):
                    self?.weatherArr.append(success)
                case .failure(let failure):
                    self?.errorMessage = failure.errorDescription
            }
            
            
        })
        
        
    }
    
    
}
