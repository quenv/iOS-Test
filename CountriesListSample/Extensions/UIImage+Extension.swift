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
            SVGKImage.imageParser(withDataAsynchronously: flagData, onCompletion: { (img, result) in
                if let svg = img {
                    if svg.hasSize() {
                        svg.size = CLSize.imageSize
                    }
                    if let img = svg.uiImage {
                        map[url] = img
                        completionHandler(img)
                    }
                    else {
                        completionHandler(nil)
                    }
                }
            })
            
        }
    }
}
