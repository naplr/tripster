//
//  ViewController.swift
//  tripster
//
//  Created by Napol Rachatasumrit on 6/11/16.
//  Copyright © 2016 Napol Rachatasumrit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textField.delegate = self;
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func selectImage(sender: UITapGestureRecognizer) {
        textField.resignFirstResponder();
        label.text = "Hello World!";
        
        let imagePickerController = UIImagePickerController();
        imagePickerController.sourceType = .PhotoLibrary
        
        imagePickerController.delegate = self;
        presentViewController(imagePickerController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.label.text = textField.text;
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion:nil);
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage;
        imageView.image = selectedImage;
        dismissViewControllerAnimated(true, completion:nil);
    }


}

