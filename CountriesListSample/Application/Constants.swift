//
//  Constants.swift
//  CountriesList
//
//  Created by QueNV on 10/24/18.
//  Copyright © 2018 smartosc. All rights reserved.
//

import Foundation
import CoreGraphics

struct CLString {
    static let emptyString           : String =  ""
    static let mainTitle             : String =  "Countries"
    static let mainStoryboardName    : String =  "Main"
    static let unknown               : String =  "Unknown"
    static let defaultImageName      : String =  "default_image"
    static let placeholderName       : String =   "No data"
}

struct CLMessage {
    static let dataError              : String =  "Data parsing error"
    static let retrieveError          : String =  "Can't retrieve countries."
    static let titleError             : String =  "Error"
}

struct CLSize {
    static let headerHeight           : CGFloat =  45
}
