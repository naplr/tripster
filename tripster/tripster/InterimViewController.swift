//
//  InterimViewController.swift
//  tripster
//
//  Created by Napol Rachatasumrit on 6/12/16.
//  Copyright © 2016 Napol Rachatasumrit. All rights reserved.
//

import UIKit

class InterimViewController: UIViewController {
    
    var allImages:[ImageWithDetail] = []
    var selectedImages:[ImageWithDetail] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let view = segue.destinationViewController as? DayImageViewerViewController {
            view.allImages = self.allImages
            view.selectedImages = self.selectedImages
        }
    }
}
