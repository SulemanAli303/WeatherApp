//
//  String+Extensions.swift
//  WeatherApp
//
//  Created by Suleman Ali on 25/10/2022.
//

import Foundation
extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
