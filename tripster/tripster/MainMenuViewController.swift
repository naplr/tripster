//
//  MainMenuViewController.swift
//  tripster
//
//  Created by Tadpol Rachatasumrit on 6/12/16.
//  Copyright © 2016 Napol Rachatasumrit. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var popup: UIView!
    @IBOutlet weak var popupButton: UIButton!
    @IBOutlet weak var popupLabel: UILabel!
    
    @IBAction func zeroButton(sender: AnyObject) {
        startLoop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.popup.hidden = true
        self.popupButton.hidden = true
        self.popupLabel.hidden = true
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "page2")!)
        // Do any additional setup after loading the view.
    }
    
    func startLoop() {
        var offset = 0
        while(true) {
            if (checkLocationAndPopup(offset)) {
                break
            }
            
            sleep(5)
            offset++
        }
    }
    
    func checkLocationAndPopup(offset:Int) -> Bool{
        let latitude = 10.75 + Double(offset)
        let longitude = 100.53
        let resultString = checkLocation(Float(latitude), longitude: Float(longitude))
        let data = resultString!.dataUsingEncoding(NSUTF8StringEncoding)
        print(resultString)
        
        return checkResult(data!)
    }
    
    static let host_url = "http://127.0.0.1:8000"
    func checkResult(resultData:NSData) -> Bool {
        let json = try! NSJSONSerialization.JSONObjectWithData(resultData, options: .AllowFragments)
        
        if let found = json["found"] as! String? {
            if found == "TRUE" {
                let username = json["username"] as! String
                let image_url_path = json["image_url"] as! String
                
                let image_url = MainMenuViewController.host_url + image_url_path
                
                print("YES")
                print("\(username)")
                print("\(image_url)")
                
                self.popupLabel.text = "Your Friend \(username) Has Discovered A Place Around Here Before!"
                
                self.popup.hidden = false
                self.popupButton.hidden = false
                self.popupLabel.hidden = false
                
                return true
            }
        }
        
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Your method to upload image with parameters to server.
    let url = host_url + "/api/v1/check-location/"
    func checkLocation(latitude:Float, longitude: Float) -> NSString?{
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
        
        return returnString
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
