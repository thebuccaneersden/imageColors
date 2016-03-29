//
//  APIClient.swift
//  imageColors
//
//  Created by Robinson Presotto on 10/01/2016.
//  Copyright © 2016 Robitto. All rights reserved.
//

import AlamofireImage
import Alamofire
import UIKit

class APIClient {
    static let sharedInstance = APIClient()
    
    func randomImages(imageSize: CGSize, completionHandler: (imageData: UIImage) -> Void) {

        Alamofire.request(.GET, "https://unsplash.it/\(imageSize.width)/\(imageSize.height)/?random")
            .responseImage { response in

            if let image = response.result.value {
                completionHandler(imageData: image)
            }
                
        }
        
    }
    
}
