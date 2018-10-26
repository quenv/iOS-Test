//
//  NSObjectExtension.swift
//  CountriesList
//
//  Created by QueNV on 10/25/18.
//  Copyright © 2018 smartosc. All rights reserved.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
