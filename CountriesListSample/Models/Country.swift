//
//  Country.swift
//  CountriesListSample
//
//  Created by admin on 10/26/18.
//  Copyright © 2018 QueNguyen. All rights reserved.
//

import Foundation

struct Country: Codable {

    enum CodingKeys: String, CodingKey {
        case flagUrl = "flag"
        case name
        case capital
        case population
        case region
        case alpha3Code
        case borders
    }
    
    // MARK: - Properties
    let flagUrl: String
    let name: String
    let capital: String
    let population: Int
    let region: String
    let alpha3Code: String
    let borders: [String]
    
    // MARK: - init
    init(flagUrl: String, name: String, capital: String, population: Int, region: String, alpha3Code: String, borders: [String]) {
        self.flagUrl = flagUrl
        self.name = name
        self.capital = capital
        self.population = population
        self.region = region
        self.alpha3Code = alpha3Code
        self.borders = borders
    }
}
