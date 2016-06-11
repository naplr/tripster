//
//  SelectImageViewController.swift
//  tripster
//
//  Created by Napol Rachatasumrit on 6/11/16.
//  Copyright © 2016 Napol Rachatasumrit. All rights reserved.
//

import UIKit
import Photos

class SelectImageViewController: UIViewController {
    var startDate: NSDate!
    var endDate: NSDate!
    
    var images:[UIImage] = []

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "\(startDate) and \(endDate)"
        
        fetchPhotosInRange(startDate, endDate: endDate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchPhotosInRange(startDate:NSDate, endDate:NSDate) {
        
        let imgManager = PHImageManager.defaultManager()
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.synchronous = true
        requestOptions.networkAccessAllowed = true
        
        // Fetch the images between the start and end date
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "creationDate > %@ AND creationDate < %@", startDate, endDate)
        
        images = []
        
        if let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: fetchOptions) {
            // If the fetch result isn't empty,
            // proceed with the image request
            if fetchResult.count > 0 {
                // Perform the image request
                for var index = 0 ; index < fetchResult.count ; index++ {
                    let asset = fetchResult.objectAtIndex(index) as! PHAsset
                    imgManager.requestImageDataForAsset(asset, options: requestOptions, resultHandler: { (imageData: NSData?, dataUTI: String?, orientation: UIImageOrientation, info: [NSObject : AnyObject]?) -> Void in
                        if let imageData = imageData {
                            if let image = UIImage(data: imageData) {
                                // Add the returned image to your array
                                self.images += [image]
                            }
                        }
                        if self.images.count == fetchResult.count {
                            // Do something once all the images
                            // have been fetched. (This if statement
                            // executes as long as all the images
                            // are found; but you should also handle
                            // the case where they're not all found.)
                            print(self.images.count)
                        }
                    })
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
