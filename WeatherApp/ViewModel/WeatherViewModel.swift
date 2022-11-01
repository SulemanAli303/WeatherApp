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
        LocationService.shared.onLatestPlaceMarkUpdate = {
           [weak self]  loc in
            guard let self = self else {return}
            self.getWeather(locationName: loc)
            
        }
        
        LocationService.shared.start()
      
        
        group.notify(queue: .main) {
            self.isShowProgress = false
            self.isReloadNeed = true
        }
        
    }
    
    private func getWeather(locationName:String){
        
        group.enter()
        NetworkManager().dashboard(loc: locationName,completion: {
            [weak self] result,error  in
            self?.group.leave()
            if let weatherResponse = result {
                self?.weatherArr.append(weatherResponse)
            }else if let error = error{
                self?.errorMessage = error
            }
        })
    }
    
    
}
