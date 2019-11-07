//
//  CityModel.swift
//  WorkLama
//
//  Created by Mahendra Vishwakarma on 07/11/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import Foundation

// MARK: - City
public struct City: Codable {
    let id: Int
    let name, country: String
    let coord: Coord
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double?
}

typealias Cities = [City]
