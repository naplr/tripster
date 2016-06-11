//
//  DayImageViewerViewController.swift
//  tripster
//
//  Created by Napol Rachatasumrit on 6/12/16.
//  Copyright © 2016 Napol Rachatasumrit. All rights reserved.
//

import UIKit

class DayImageViewerViewController: UIViewController {

    var allImages:[ImageWithDetail] = []
    var selectedImages:[ImageWithDetail] = []
    
    var imageGroups = [Int:[ImageWithDetail]]()

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let heightPerItem = 200
        let itemWidth = CGFloat(400)
        let gapBetweenItem = 30
        
        self.imageGroups = groupImagesByDate(selectedImages)
        let numberOfDays = self.imageGroups.count
        
        // Do any additional setup after loading the view.
        scrollView.contentSize.height = CGFloat((numberOfDays + 2) * heightPerItem)
        
        var index = 0;
        for k in self.imageGroups.keys.sort() {
            let imageGroup = self.imageGroups[k]!
            let imageView = UIImageView(frame: CGRectMake(
                0,
                CGFloat(index*(heightPerItem+gapBetweenItem)),
                itemWidth,
                CGFloat(heightPerItem)))
            imageView.image = imageGroup[0].image;
            
            let memoriesLabel = UILabel(frame: CGRectMake(
                0,
                CGFloat(index*(heightPerItem+gapBetweenItem)),
                itemWidth,
                CGFloat(heightPerItem)))
            memoriesLabel.text = ("total memories: \(imageGroup.count)")
            memoriesLabel.textColor = UIColor.whiteColor()
            
            let numDayLabel = UILabel(frame: CGRectMake(
                0,
                CGFloat(index*(heightPerItem+gapBetweenItem-10)),
                itemWidth,
                CGFloat(heightPerItem)))
            numDayLabel.text = "Day \(index+1)"
            numDayLabel.textColor = UIColor.whiteColor()
            
            let dateLabel = UILabel(frame: CGRectMake(
                0,
                CGFloat(index*(heightPerItem+gapBetweenItem+10)),
                itemWidth,
                CGFloat(heightPerItem)))
            dateLabel.text = "Date \(k)"
            dateLabel.textColor = UIColor.whiteColor()
            
            self.scrollView.addSubview(imageView);
            self.scrollView.addSubview(memoriesLabel);
            self.scrollView.addSubview(numDayLabel);
            self.scrollView.addSubview(dateLabel);
            
            index++
        }
        
//        for (index, image) in selectedImages.enumerate() {
//            let imageView = UIImageView(frame: CGRectMake(0, CGFloat(index*(400+30)), 400, 400))
//            imageView.image = image.image;
//            self.scrollView.addSubview(imageView);
//        }
        
//        var index = 0;
//        for k in self.imageGroups.keys.sort() {
//            for image in self.imageGroups[k]! {
//                let imageView = UIImageView(frame: CGRectMake(0, CGFloat(index*(400+30)), 400, 400))
//                imageView.image = image.image;
//                self.scrollView.addSubview(imageView);
//                index++
//            }
//        }

        // Do any additional setup after loading the view.
    }
    
    func groupImagesByDate(images: [ImageWithDetail]) -> [Int:[ImageWithDetail]] {
        var result = [Int:[ImageWithDetail]]()
        for image in images {
            let creationDate = MyDate(date: image.creationDate!).getValue()
            
            print(creationDate)
            if var group = result[creationDate] {
                group += [image]
                result[creationDate] = group
            } else {
                result[creationDate] = [image]
            }
        }
        
        return result
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
