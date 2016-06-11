//
//  ImageWithDetail.swift
//  tripster
//
//  Created by Napol Rachatasumrit on 6/12/16.
//  Copyright © 2016 Napol Rachatasumrit. All rights reserved.
//

import UIKit
import Photos

class ImageWithDetail {
    var image: UIImage
    var creationDate: NSDate?
    var location: CLLocation?
    
    init(image: UIImage, creationDate: NSDate?, location: CLLocation?) {
        // Initialize stored properties.
        self.image = image
        self.creationDate = creationDate
        self.location = location
    }
}
