//
//  DecodeViewController.swift
//  HexBT
//
//  Created by Pan Ziyue on 15/6/14.
//  Copyright (c) 2014 Pan Ziyue. All rights reserved.
//

import UIKit

class DecodeViewController: UITableViewController {
    
    // Variables here
    @IBOutlet var userInput : GCPlaceholderTextView!
    @IBOutlet var output : GCPlaceholderTextView!

    override init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userInput.placeholder = "Input encoded message here (make sure there is only 1 type of encoding)"
        output.placeholder = "Output decoded message here (note that MD5 and SHA1 cannot be decoded)"
        
        // Set background colors
        self.tableView.backgroundView = nil
        self.tableView.backgroundColor = UIColor.clearColor()
        self.view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        // Set custom title view
        var label = UILabel(frame: CGRectMake(0, 0, 400, 44))
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.text = "Decoder"
        label.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        self.navigationItem.titleView = label;
        
        // Setup gestures
        let tapGesture = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        var swipeGesture = UISwipeGestureRecognizer(target: self, action: "dismissKeyboard")
        swipeGesture.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(tapGesture)
        self.view.addGestureRecognizer(swipeGesture)
    }
    
    @IBAction func setType(sender:AnyObject) {
        if userInput.text.utf16Count >= 2 {
            let input : Int = detectType(userInput.text)
            switch input {
            case 0:
                output.text = CommonObjCMethods.binToText(userInput.text)
                break
            case 1:
                output.text = CommonObjCMethods.hexToText(userInput.text)
                break
            case 2:
                output.text = CommonObjCMethods.base64Decode(userInput.text)
                break
            default:
                SVProgressHUD.showErrorWithStatus("Error: Conversion Error!")
                break
            }
        } else {
            SVProgressHUD.showErrorWithStatus("Error: No text")
        }
        dismissKeyboard()
        
        // Final layer of error catching
        if output.text.utf16Count==0 {
            SVProgressHUD.showErrorWithStatus("Error: Invalid Text!")
        }
    }
    
    @IBAction func share(sender:AnyObject) {
        if output.text.utf16Count > 0 {
            let sharedText : String = output.text
            SVProgressHUD.showWithStatus("Loading...")
            let activityVC = UIActivityViewController(activityItems: [sharedText], applicationActivities: nil)
            self.presentViewController(activityVC, animated: true, completion: {
                SVProgressHUD.dismiss()
                })
        } else {
            SVProgressHUD.showErrorWithStatus("Nothing to share!")
        }
    }
    
    @IBAction func pasteToTextView(sender:AnyObject) {
        let pd = UIPasteboard.generalPasteboard()
        userInput.text = pd.string
        dismissKeyboard()
        setType(self)
    }
    
    func detectType (input:String) -> (Int) {
        if CommonObjCMethods.isBinary(input) {
            return 0
        } else if CommonObjCMethods.isHexadecimal(input) {
            return 1
        } else if CommonObjCMethods.isBase64Data(input) {
            return 2
        } else {
            return -1
        }
    }
    
    func dismissKeyboard () {
        userInput.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}