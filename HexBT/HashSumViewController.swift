//
//  HashSumViewController.swift
//  HexBT
//
//  Created by Pan Ziyue on 13/6/14.
//  Copyright (c) 2014 Pan Ziyue. All rights reserved.
//

import UIKit

class HashSumViewController: UITableViewController {
    
    // Variables here
    @IBOutlet var textToHash : GCPlaceholderTextView
    @IBOutlet var md5Disp : UITextView
    @IBOutlet var sha1Disp : UITextView

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
        
        textToHash.placeholder = "Input text here"
        
        // Setup title attributes
        var titleV = UILabel(frame: CGRectMake(0, 0, 400, 44))
        titleV.textAlignment = NSTextAlignment.Center
        titleV.textColor = UIColor.whiteColor()
        titleV.text = "Text to Hash Sum"
        titleV.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        self.navigationItem.titleView=titleV
        
        // Setup background view
        self.tableView.backgroundView = nil
        self.tableView.backgroundColor = UIColor.clearColor()
        self.view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        // Setup gesture recognisers
        let tapGesture = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tapGesture)
        var swipeGesture = UISwipeGestureRecognizer(target: self, action: "dismissKeyboard")
        swipeGesture.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeGesture)
    }
    
    @IBAction func convert(sender:AnyObject) {
        if textViewHasText(textToHash) {
            md5Disp.text = CommonObjCMethods.md5(textToHash.text)
            sha1Disp.text = CommonObjCMethods.sha1(textToHash.text)
            textToHash.resignFirstResponder()
        } else {
            SVProgressHUD.showErrorWithStatus("Error: No text!")
            md5Disp.text = ""
            sha1Disp.text = ""
            textToHash.resignFirstResponder()
        }
    }
    
    @IBAction func share(sender:AnyObject) {
        if textViewHasText(md5Disp) && textViewHasText(sha1Disp) {
            let combined = "MD5 Sum: \(md5Disp.text)\nSHA1 Sum: \(sha1Disp.text)" // Awesome string interpolation feature right here
            SVProgressHUD.showWithStatus("Loading...")
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.1*Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                let activityVC = UIActivityViewController(activityItems: [combined], applicationActivities: nil)
                self.presentViewController(activityVC, animated: true, completion: {
                    SVProgressHUD.dismiss()
                    })
                })
        } else {
            SVProgressHUD.showErrorWithStatus("Error: You haven't generated a hash!")
        }
    }
    
    func dismissKeyboard() {
        textToHash.resignFirstResponder()
    }
    
    func textViewHasText (textView : UITextView) -> (Bool) {
        if textView.text.utf16count > 0 {
            return true
        } else {
            return false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}