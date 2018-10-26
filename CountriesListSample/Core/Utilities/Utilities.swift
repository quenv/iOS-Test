//
//  Utilities.swift
//  CountriesList
//
//  Created by admin on 10/24/18.
//  Copyright © 2018 smartosc. All rights reserved.
//

import Foundation


class Utilities: NSObject {
    // MARK: - Use when the request include parameters
    class func createURLFromParameters(parameters: OrderedDictionary<String, String>) -> String {
        var components = URLComponents()
        components.path = ""
        if parameters.count > 0 {
            components.queryItems = [URLQueryItem]()
            for key in parameters.keys {
                let queryItem = URLQueryItem(name: key, value: parameters.dict[key])
                components.queryItems!.append(queryItem)
            }
        }
        return components.string!
    }
}


