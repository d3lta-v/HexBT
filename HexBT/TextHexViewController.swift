//
//  TextHexViewController.swift
//  HexBT
//
//  Created by Pan Ziyue on 11/6/14.
//  Copyright (c) 2014 Pan Ziyue. All rights reserved.
//

import UIKit

class TextHexViewController: UITableViewController {
    
    // Variables here
    @IBOutlet var textToHex : GCPlaceholderTextView
    @IBOutlet var hexDisp : GCPlaceholderTextView

    init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
    }
    
    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        textToHex.placeholder = "Input text here"
        hexDisp.placeholder = "Output hexadecimal here"
        
        // Set background colors
        self.tableView.backgroundView = nil
        self.tableView.backgroundColor = UIColor.clearColor()
        self.view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        // Set title text attributes
        var label = UILabel(frame: CGRectMake(0, 0, 400, 44))
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.text = "Text to Hexadecimal Converter"
        label.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        self.navigationItem.titleView = label;
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tapGesture)
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: "dismissKeyboard")
        swipeGesture.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeGesture)
    }
    
    @IBAction func convert(sender:AnyObject) {
        if textToHex.text.utf16count<1 {
            let alert = UIAlertView(title: "Error: No text!", message: nil, delegate: nil, cancelButtonTitle: "Okay")
            hexDisp.text=""
            textToHex.resignFirstResponder()
        } else if textToHex.hasText() {
            hexDisp.text = CommonObjCMethods.textToHex(textToHex.text)
            textToHex.resignFirstResponder()
        } else if hexDisp.hasText()||(!textToHex.hasText()) {
            let alert = UIAlertView(title: "Error: Invalid or no text!", message: nil, delegate: nil, cancelButtonTitle: "Okay")
            alert.show()
            textToHex.resignFirstResponder()
        } else {
            textToHex.resignFirstResponder()
        }
    }
    
    @IBAction func share(sender:AnyObject) {
        if hexDisp.hasText() {
            SVProgressHUD.showWithStatus("Loading...")
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.1*Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                let actViewCtrl = UIActivityViewController(activityItems: [self.hexDisp.text], applicationActivities: nil)
                self.presentViewController(actViewCtrl, animated: true, completion: {SVProgressHUD.dismiss()})
                })
        } else {
            let alert = UIAlertView(title: "Nothing to share!", message: nil, delegate: nil, cancelButtonTitle: "Okay")
            alert.show()
        }
    }
    
    func dismissKeyboard() {
        textToHex.resignFirstResponder()
        hexDisp.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
