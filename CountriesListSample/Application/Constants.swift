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
    static let noInfo                : String =   "<no info>"
    static let capitalSection        : String =   "capital"
    static let regionSection         : String =   "region"
    static let populationSection     : String =   "population"
    static let nativeNameSection     : String =   "nativeName"
    static let searchPlaceholder     : String =   "Search countries..."
    static let showDetailCountry     : String =   "showDetailCountry"
}

struct CLMessage {
    static let dataError              : String =  "Data parsing error"
    static let retrieveError          : String =  "Can't retrieve countries."
    static let titleError             : String =  "Error"
}

struct CLSize {
    static let headerHeight           : CGFloat =  45
    static let numberDetail           : Int     =  4
    static let scaleFlagImage         : CGFloat =  1.7
    static let oneRow                 : Int     =  1
}
