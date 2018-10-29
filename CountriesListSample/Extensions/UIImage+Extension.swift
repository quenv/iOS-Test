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
        
        if let img = map[url] {
            DispatchQueue.global().async {
                completionHandler(img)
            }
            return
        }
        
        APIManager().getFlag(flagUrl: url) { (data, err)  in
            guard let flagData = data else {
                completionHandler(nil)
                return
            }

            DispatchQueue.global().async {
                let image = SVGKImage.init(dataAsynchronously: flagData, onCompletion: { (image, result) in
                })
                guard let img = image else {
                    completionHandler(nil)
                    return
                }
                if img.hasSize() {
                    img.size = CLSize.imageSize
                }
                if let img = img.uiImage {
                    map[url] = img
                    completionHandler(img)
                }
            }
        
        }
    }
}
