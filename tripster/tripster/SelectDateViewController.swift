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
    
    var currentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.hidden = true
        doneButton.hidden = true
        
        // Do any additional setup after loading the view.
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
        hideButton()
    }
    
    @IBAction func endDateClicked(sender: AnyObject) {
        datePicker.hidden = false
        doneButton.hidden = false
        
        currentButton = endDateButton
        hideButton()
    }
    
    @IBAction func startDatePickerChanged(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        
        let strDate = dateFormatter.stringFromDate(datePicker.date)
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
    
}

