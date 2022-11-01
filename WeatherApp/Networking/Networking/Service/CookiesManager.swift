//
//  CookiesManager.swift
//  WeatherApp
//
//  Created by Suleman Ali on 25/10/2022.
//

import Foundation
class CookiesManager{
    
    static let shared = CookiesManager()
    private var keyCookies = "NetworkCookiesKey"
    private init(){
        
    }
    func loadCookies(){
        guard let cookieArray = UserDefaults.standard.array(forKey: keyCookies) as? [[HTTPCookiePropertyKey: Any]] else { return }
        for cookieProperties in cookieArray {
            if let cookie = HTTPCookie(properties: cookieProperties) {
                HTTPCookieStorage.shared.setCookie(cookie)
            }
        }
    }
    
     func saveCookies(response: HTTPURLResponse) {
        let headerFields = response.allHeaderFields as! [String: String]
        let url = response.url
        let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url!)
        var cookieArray = [[HTTPCookiePropertyKey: Any]]()
        for cookie in cookies {
            if let cookieProperties = cookie.properties {
                cookieArray.append(cookieProperties)
            }
        }
    
         UserDefaults.standard.set(cookieArray, forKey: keyCookies)
         UserDefaults.standard.synchronize()
    }
    
    
    
    
    
}
