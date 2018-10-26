//
//  NSError+Extension.swift
//  CountriesListSample
//
//  Created by admin on 10/26/18.
//  Copyright © 2018 QueNguyen. All rights reserved.
//

import Foundation

extension NSError {
    static func createError(_ code: Int = 400, description: String) -> NSError {
        return NSError(domain: NSCocoaErrorDomain,
                       code: code,
                       userInfo: [
                        "NSLocalizedDescription" : description
            ])
    }
}
