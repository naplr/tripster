//
//  SelectDateViewController.swift
//  tripster
//
//  Created by Napol Rachatasumrit on 6/11/16.
//  Copyright © 2016 Napol Rachatasumrit. All rights reserved.
//

import UIKit

class SelectDateViewController: UIViewController {
    
    @IBOutlet weak var startDateButton: UIButton!
    @IBOutlet weak var endDateButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var doneButton: UIButton!
    
    var startDate: NSDate!
    var endDate: NSDate!
    
    var currentButton: UIButton!
    
    var isStartDate: Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.hidden = true
        doneButton.hidden = true
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "page3")!)
        
        checkLocation(130.75, longitude: 100.59)
        // Do any additional setup after loading the view.
    }
    
    // Your method to upload image with parameters to server.
    let url = "http://127.0.0.1:8000/api/v1/check-location/"
    func checkLocation(latitude:Float, longitude: Float){
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "POST"
        
        var boundary = NSString(format: "---------------------------14737809831466499882746641449")
        var contentType = NSString(format: "multipart/form-data; boundary=%@",boundary)
        //  println("Content Type \(contentType)")
        request.addValue(contentType as String, forHTTPHeaderField: "Content-Type")
        
        var body = NSMutableData()
        
        // latitude
        body.appendData(NSString(format: "\r\n--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"Content-Disposition: form-data; name=\"latitude\"\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("\(latitude)".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!)
        
        // longitude
        body.appendData(NSString(format: "\r\n--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"Content-Disposition: form-data; name=\"longitude\"\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("\(longitude)".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!)
        
        request.HTTPBody = body
        
        var returnData = try! NSURLConnection.sendSynchronousRequest(request, returningResponse: nil)
        
        var returnString = NSString(data: returnData, encoding: NSUTF8StringEncoding)
        print("returnString \(returnString)")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideButton() {
        startDateButton.hidden = true
        endDateButton.hidden = true
    }
    
    func showButton() {
        startDateButton.hidden = false
        endDateButton.hidden = false
    }
    
    @IBAction func startDateClicked(sender: UIButton) {
        datePicker.hidden = false
        doneButton.hidden = false
        
        currentButton = startDateButton
        self.isStartDate = true
        hideButton()
    }
    
    @IBAction func endDateClicked(sender: AnyObject) {
        datePicker.hidden = false
        doneButton.hidden = false
        
        currentButton = endDateButton
        self.isStartDate = false
        hideButton()
    }
    
    @IBAction func startDatePickerChanged(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        
       let strDate = dateFormatter.stringFromDate(datePicker.date)
        
        if isStartDate {
            startDate = datePicker.date
        } else {
            endDate = datePicker.date
        }
        
       currentButton.setTitle(strDate, forState: .Normal)
    }
    
    @IBAction func doneButtonClicked(sender: AnyObject) {
        datePicker.hidden = true
        doneButton.hidden = true
        
        showButton()
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
        
        if let view = segue.destinationViewController as? SelectImageViewController {
            view.startDate = startDate
            view.endDate = endDate
        }
    }
}

