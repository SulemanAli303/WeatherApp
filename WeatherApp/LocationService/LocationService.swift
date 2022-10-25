//
//  LocationService.swift
//  WeatherApp
//
//  Created by Suleman Ali on 25/10/2022.
//

import Foundation
import CoreLocation
class LocationService: NSObject, CLLocationManagerDelegate {
    
    static let shared  = LocationService()
    private override init() {
        super.init()
        self.start()
    }
    private let locationManager = CLLocationManager()
    private let geoCoder = CLGeocoder()
    private(set) var latestPlaceMark: CLPlacemark?
    private (set) var currentCity:String = ""
    var onLatestPlaceMarkUpdate: (() -> ())?
    var shouldStopOnUpdate: Bool = true
    func start() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func stop() {
        locationManager.stopUpdatingLocation()
    }
    
    fileprivate func updatePlaceMark(for location: CLLocation) {
        geoCoder.reverseGeocodeLocation(location) { [weak self] placeMarks, error in
            if let placeMark = placeMarks?.first {
                self?.latestPlaceMark = placeMark
                if let city = placeMark.locality,let country = placeMark.country {
                    self?.currentCity = city + ", " + country
                }
                self?.onLatestPlaceMarkUpdate?()
                if self?.shouldStopOnUpdate ?? false {
                    self?.stop()
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            updatePlaceMark(for: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("CurrentPlaceMarkUpdater: \(error)")
    }
    
}
