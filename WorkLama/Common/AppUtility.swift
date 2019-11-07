//
//  AppUtility.swift
//  WorkLama
//
//  Created by Mahendra Vishwakarma on 06/11/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import Foundation

class AppUtility {
    static let cityCollectionXIBName = "CityCollectionView"
    static var citiesList:Cities?
    static let fileName = "city.list"
    static let weatherURL = "http://api.openweathermap.org/data/2.5/weather?id=%i&APPID=a23f7e354f06e4c0468cab08623f6b05"
    
    // loading local data 
    static func getLocalCityData() {
    
        WebServices.fetchJSONData(fileName: fileName, decode: { (json) -> Cities? in
            guard let response = json as? Cities else{
                return nil
            }
            
            return response
        }) { (result) in
            switch result {
            case .success(let data):
                citiesList = data
                break
            case .failure(_) :
                
                break
                
            }
        }
    }
}
