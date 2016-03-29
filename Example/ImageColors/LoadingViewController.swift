//
//  ViewController.swift
//  imageColors
//
//  Created by Robinson Presotto on 10/01/2016.
//  Copyright © 2016 Robitto. All rights reserved.
//

import UIKit
import ImageColors

protocol loadingViewDelegate {
    func loadImageColors(image:UIImage, colors:UIImageColors)
}

class LoadingViewController: UIViewController {
    var delegate: loadingViewDelegate?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        APIClient.sharedInstance.randomImages(CGSize(width: 800, height: 600)) { (imageData) -> Void in
            
            imageData.getColors({ (imageColors) -> Void in
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    self.delegate?.loadImageColors(imageData, colors: imageColors)
                })
                
            })
            
        }
        
    }
    
}