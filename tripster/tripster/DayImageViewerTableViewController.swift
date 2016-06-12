//
//  DayImageViewerTableViewController.swift
//  tripster
//
//  Created by Napol Rachatasumrit on 6/12/16.
//  Copyright © 2016 Napol Rachatasumrit. All rights reserved.
//

import UIKit

class DayImageViewerTableViewController: UITableViewController {

    var allImages:[ImageWithDetail] = []
    var selectedImages:[ImageWithDetail] = []
    var imageGroups = [Int:[ImageWithDetail]]()
    var keys:[Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        imageGroups = groupImagesByDate(selectedImages)
        keys = [Int](imageGroups.keys)
        keys = keys.sort()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "page7")!)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    func groupImagesByDate(images: [ImageWithDetail]) -> [Int:[ImageWithDetail]] {
        var result = [Int:[ImageWithDetail]]()
        for image in images {
            let creationDate = MyDate(date: image.creationDate!).getValue()
            print(creationDate)
            print(image.location?.coordinate.latitude)
            print(image.location?.coordinate.longitude)
            
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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageGroups.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "DayImageViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DayImageViewerTableViewCell
        
        let key = self.keys[indexPath.row]
        let imageGroup = imageGroups[key]
        
        let dateString = "\(key/100)/\(key%100)"
        cell.dateLabel.text = dateString
        cell.numDayLabel.text = "\(indexPath.row + 1)"
        cell.dayImage.image = imageGroup![0].image
        cell.totalImageLabel.text = "\(imageGroup!.count)"
        
        cell.dayImageIcon.image = UIImage(named: "page7-2")

        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let view = segue.destinationViewController as? SingleDayImageTableViewController {
            if let selectedCell = sender as? DayImageViewerTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedCell)!
                let key = keys[indexPath.row]
                
                view.date = key
                view.todaySelectedImages = imageGroups[key]!
            }
        } else if let view = segue.destinationViewController as? ImageViewerViewController {
            if let selectedCell = sender as? DayImageViewerTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedCell)!
                let key = keys[indexPath.row]
                
                view.date = key
                view.todaySelectedImages = imageGroups[key]!
            }
        } else if let view = segue.destinationViewController as? TabImageViewerViewController {
            if let selectedCell = sender as? DayImageViewerTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedCell)!
                let key = keys[indexPath.row]
                
                view.date = key
                view.todaySelectedImages = imageGroups[key]!
            }
        }
    }
}
