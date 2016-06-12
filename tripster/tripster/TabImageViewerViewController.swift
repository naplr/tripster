//
//  ImageViewerViewController.swift
//  tripster
//
//  Created by Napol Rachatasumrit on 6/11/16.
//  Copyright © 2016 Napol Rachatasumrit. All rights reserved.
//

import UIKit

class TabImageViewerViewController: UIViewController {
    var todaySelectedImages:[ImageWithDetail] = []
    var date: Int = 0
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let heightPerItem = 800
        let itemWidth = CGFloat(500)
        let gapBetweenItem = 45
        
        let imageCount = self.todaySelectedImages.count
        
        // Do any additional setup after loading the view.
        scrollView.contentSize.height = CGFloat((imageCount + 2) * heightPerItem)
        
        for (index, image) in todaySelectedImages.enumerate() {
            let imageView = UIImageView(frame: CGRectMake(
                2,
                CGFloat(index*(heightPerItem+gapBetweenItem)),
                itemWidth,
                CGFloat(heightPerItem)))
            imageView.image = image.image
            
            self.scrollView.addSubview(imageView);
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
