//
//  MainRequest.swift
//  CountriesList
//
//  Created by admin on 10/24/18.
//  Copyright © 2018 QueNguyen. All rights reserved.
//

import Foundation

struct APIRequest: BaseRequestable {
    
    // MARK: - Properties
    var parameters: [String: Any]?
    var path: String
    
    // MARK: - Config api get all country
    init(withAllCountry url: String = ConfigURL.apiGetAllCountry) {
        self.path = url
        self.parameters = nil
    }
    
    // MARK: - Config api get flag country
    init(withFlag url: String) {
        self.path = url
        self.parameters = nil
    }
}
