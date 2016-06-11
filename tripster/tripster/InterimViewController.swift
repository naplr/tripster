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
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "page6")!)
        // Do any additional setup after loading the view.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let view = segue.destinationViewController as? DayImageViewerViewController {
            view.allImages = self.allImages
            view.selectedImages = self.selectedImages
        } else if let view = segue.destinationViewController as? DayImageViewerTableViewController {
            view.allImages = self.allImages
            view.selectedImages = self.selectedImages
        }
    }
}
