//
//  MainService.swift
//  CountriesList
//
//  Created by QueNV on 10/24/18.
//  Copyright © 2018 smartosc. All rights reserved.
//

import Foundation
import Alamofire

struct APIManager: Requestable {
    
    func getAllCountryList(completionHandler: @escaping(_ listCountries: [Country]?, _ error: NSError?) -> Void) {
        let apiRequest = APIRequest()
        request(apiRequest).responseDecodable { (response: DataResponse<[Country]>) in
            switch response.result {
            case .success(let country):
                completionHandler(country, nil)
            case .failure(_):
                completionHandler(nil, NSError.createError(description: CLMessage.dataError))
            }
        }
    }
    
    func getFlag(flagUrl: String, completionHandler: @escaping(_ flagData: Data?, _ error: NSError?) -> Void) {
        let apiRequest = APIRequest(withFlag: flagUrl)
        request(apiRequest).responseData { (response) in
            switch response.result {
            case .success(let flagData):
                DispatchQueue.global().async {
                    completionHandler(flagData, nil)
                }
            case .failure(_):
                completionHandler(nil, NSError.createError(description: CLMessage.dataError))
            }
        }
    }
}
