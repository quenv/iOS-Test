//
//  ImageLoadOperation.swift
//  CountriesListSample
//
//  Created by admin on 10/26/18.
//  Copyright © 2018 QueNguyen. All rights reserved.
//

import Foundation
import UIKit

typealias ImageLoadOperationCompletionHandlerType = ((UIImage) -> ())?

class ImageLoadOperation: Operation {
    
    // MARK: - Properties
    var url: String
    var completionHandler: ImageLoadOperationCompletionHandlerType
    var image: UIImage?
    
    // MARK: - init
    init(url: String) {
        self.url = url
    }
    
    override func main() {
        if isCancelled {
            return
        }
        UIImage.downloadImageFromUrl(url) { [weak self] (image) in
            guard let strongSelf = self,
                !strongSelf.isCancelled,
                let image = image else {
                    return
            }
            strongSelf.image = image
            strongSelf.completionHandler?(image)
        }
    }
}
