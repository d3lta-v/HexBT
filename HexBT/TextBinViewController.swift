//
//  TextBinViewController.swift
//  HexBT
//
//  Created by Pan Ziyue on 11/6/14.
//  Copyright (c) 2014 Pan Ziyue. All rights reserved.
//

import UIKit

class TextBinViewController: UITableViewController {
    
    // Variables here
    @IBOutlet var textToBinary : GCPlaceholderTextView
    @IBOutlet var binaryDisp : GCPlaceholderTextView

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
        textToBinary.placeholder = "Input text here"
        binaryDisp.placeholder = "Output binary here"
        
        // Set custom title view
        var label = UILabel(frame: CGRectMake(0, 0, 400, 44))
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.text = "Text to Binary Converter"
        label.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        self.navigationItem.titleView = label;
        
        // Set background attributes
        self.tableView.backgroundView = nil
        self.tableView.backgroundColor = UIColor.clearColor()
        self.view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        // Setup gesture actions
        let tapGesture = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        var swipeGesture = UISwipeGestureRecognizer(target: self, action: "dismissKeyboard")
        swipeGesture.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(tapGesture)
        self.view.addGestureRecognizer(swipeGesture)
    }
    
    @IBAction func convert(sender:AnyObject) {
        if textToBinary.hasText() {
            //Conversion engine CSIMUX (Convertor, aScIi, Mutable Unified X-over Engine)
            let converted = CommonObjCMethods.textToBin(textToBinary.text)
            binaryDisp.text = converted;
            textToBinary.resignFirstResponder()
        } else if !textToBinary.hasText() || !binaryDisp.hasText() {
            let alert = UIAlertView(title: "Error: Invalid or no text!", message: nil, delegate: nil, cancelButtonTitle: "Okay")
            alert.show()
            binaryDisp.text=""
        } else {
            textToBinary.resignFirstResponder()
        }
    }
    
    @IBAction func share(sender:AnyObject) {
        if binaryDisp.hasText() {
            SVProgressHUD.showWithStatus("Loading...")
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.1*Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                var actViewCtrl = UIActivityViewController(activityItems: [self.binaryDisp.text], applicationActivities: nil)
                self.presentViewController(actViewCtrl, animated: true, completion: {SVProgressHUD.dismiss()})
            }
        } else {
            // Wrong way
            //var alertView = UIAlertView(title: "Nothing to share!", message: "", delegate: self, cancelButtonTitle: "Back", otherButtonTitles: "", nil)
            
            // Correct way
            let alert = UIAlertView(title: "Nothing to share!", message: nil, delegate: nil, cancelButtonTitle: "Back")
            alert.show()
        }
    }
    
    func dismissKeyboard() {
        textToBinary.resignFirstResponder()
        binaryDisp.resignFirstResponder()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
