//
//  Configurable.swift
//  CountriesList
//
//  Created by QueNV on 10/24/18.
//  Copyright © 2018 smartosc. All rights reserved.
//

import Foundation

var defaultConfiguration = Configuration()

protocol Configurable {
    
    /// The `configuration`.
    var configuration: Configuration { get }
    
}

// extension Configurable where Self: Requestable {
extension Configurable {
    /// `Restofire.defaultConfiguration`
    var configuration: Configuration {
        return defaultConfiguration
    }
    
}
