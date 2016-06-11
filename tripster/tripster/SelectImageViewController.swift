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

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalImageLabel: UILabel!
    @IBOutlet weak var totalSelectedLabels: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    
    var currentImageIndex = 0
    var selectedImages:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var startMonth: Int
        var endMonth: Int
        var startDay: Int
        var endDay: Int
        
        (startMonth, startDay) = getDate(startDate)
        (endMonth, endDay) = getDate(endDate)
        
        dateLabel.text = "\(startDay)-\(startMonth) TO \(endDay)-\(endMonth)"
        doneButton.hidden = true
        
        fetchPhotosInRange(startDate, endDate: endDate)
        
        self.mainImage.image = self.images[0]
        
        self.backgroundImage.image = self.images[self.currentImageIndex]
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.backgroundImage.frame
        
        self.view.insertSubview(blurView, atIndex: 5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func yesButtonClicked(sender: AnyObject) {
        self.selectedImages += [self.images[self.currentImageIndex]]
        self.totalSelectedLabels.text = "Total Selected \(self.selectedImages.count)"
        nextImage()
    }
    
    @IBAction func noButtonClicked(sender: AnyObject) {
        nextImage()
    }
    
    func nextImage() {
        self.currentImageIndex++
        
        if self.currentImageIndex >= self.images.count {
            self.mainImage.hidden = true
            self.doneButton.hidden = false
            
        } else {
            self.mainImage.image = self.images[self.currentImageIndex]
            self.backgroundImage.image = self.images[self.currentImageIndex]
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = self.backgroundImage.frame
            
            self.view.insertSubview(blurView, atIndex: 4)
        }
    }
    
    func getDate(date: NSDate) -> (Int, Int) {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        return (components.month, components.day)
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
                            self.totalImageLabel.text = "Total Images: \(self.images.count)"
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let view = segue.destinationViewController as? ImageViewerViewController {
            view.selectedImages = self.selectedImages
        }
    }
}
