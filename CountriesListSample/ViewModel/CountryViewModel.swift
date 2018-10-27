//
//  CountryViewModel.swift
//  CountriesListSample
//
//  Created by admin on 10/26/18.
//  Copyright © 2018 QueNguyen. All rights reserved.
//

import Foundation
import UIKit

struct CountryViewModel {
    
    // MARK: - Properties
    let flagUrl: String
    let name: String
    let capital: String?
    let population: Int?
    let region: String?
    let subregion: String?
    let nativeName: String?

    // MARK: - init
    init(country: Country) {
        flagUrl = country.flagUrl
        name = country.name
        capital = country.capital
        population = country.population
        region = country.region
        subregion = country.subregion
        nativeName = country.nativeName
    }
}
