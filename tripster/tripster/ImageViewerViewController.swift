//
//  ImageViewerViewController.swift
//  tripster
//
//  Created by Napol Rachatasumrit on 6/11/16.
//  Copyright © 2016 Napol Rachatasumrit. All rights reserved.
//

import UIKit

class ImageViewerViewController: UIViewController {
    
    var selectedImages:[UIImage] = []

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        print(selectedImages.count)
        // Do any additional setup after loading the view.
        
        scrollView.contentSize.height = CGFloat((selectedImages.count + 2) * 430)
        
        
        for (index, image) in selectedImages.enumerate() {
            let imageView = UIImageView(frame: CGRectMake(0, CGFloat(index*(400+30)), 400, 400))
            imageView.image = image;
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
