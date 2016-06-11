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
    
    var images:[ImageWithDetail] = []

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalImageLabel: UILabel!
    @IBOutlet weak var totalSelectedLabels: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var backgroundKy: UIImageView!
    
    var currentImageIndex = 0
    var selectedImages:[ImageWithDetail] = []
    var currentBlurView:UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startDay = MyDate(date: startDate)
        let endDay = MyDate(date: endDate)
        
        dateLabel.text = "\(startDay.day)-\(startDay.day) TO \(endDay.day)-\(endDay.month)"
        doneButton.hidden = true
        
        fetchPhotosInRange(startDate, endDate: endDate)
        
        self.mainImage.image = self.images[0].image
        
        self.backgroundImage.image = self.mainImage.image
        
        self.backgroundKy.image = UIImage(named: "page5")
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "page5")!)
        // Do any additional setup after loading the view.
    

    }
    
    
    override func viewDidLayoutSubviews() {
        updateBackgroundImage()
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
            self.backgroundImage.hidden = true
            self.yesButton.hidden = true
            self.noButton.hidden = true
        } else {
            self.mainImage.image = self.images[self.currentImageIndex].image
            updateBackgroundImage()
        }
    }
    
    func updateBackgroundImage() {
        if self.currentBlurView != nil {
            self.currentBlurView.removeFromSuperview()
        }
        
        self.backgroundImage.image = self.mainImage.image
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.backgroundImage.frame
        
        self.currentBlurView = blurView
        self.view.insertSubview(blurView, aboveSubview: self.backgroundImage)
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
                                self.images += [ImageWithDetail(image: image, creationDate: asset.creationDate,location: asset.location)]
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
        
        if let view = segue.destinationViewController as? InterimViewController {
            view.allImages = self.images
            view.selectedImages = self.selectedImages
        }
    }
}
