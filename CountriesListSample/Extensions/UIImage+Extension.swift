//
//  UIImage+Extension.swift
//  CountriesListSample
//
//  Created by admin on 10/26/18.
//  Copyright © 2018 QueNguyen. All rights reserved.
//

import Foundation
import UIKit
import SVGKit
import Alamofire


extension UIImage {
    static var map = [String : UIImage]()
    static func downloadImageFromUrl(_ url: String, completionHandler: @escaping (UIImage?) -> Void) {
        
        APIManager().getFlag(flagUrl: url) { (data, err)  in
            if let img = map[url] {
                completionHandler(img)
                return
            }
            else {
                guard let flagData = data else {
                    completionHandler(nil)
                    return
                }
                DispatchQueue.global().async {
                    guard let svg = SVGKImage.init(source: SVGKSource(inputSteam: InputStream(data: flagData))) else {
                        completionHandler(nil)
                        return
                    }
                    if svg.hasSize() {
                        svg.size = CGSize(width: 100, height: 100)
                    }
                    if let img = svg.uiImage {
                        map[url] = img
                        completionHandler(img)
                    }
                    else {
                        completionHandler(nil)
                    }
                }
            }
        }
    }
    
    static func getImageCacheFromURL(_ url: String) -> UIImage? {
        if let img = map[url] {
            return img
        }
        return nil
    }
}
