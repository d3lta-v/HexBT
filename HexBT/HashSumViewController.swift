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
    @IBOutlet var textToHash : GCPlaceholderTextView!
    @IBOutlet var md5Disp : UITextView!
    @IBOutlet var sha1Disp : UITextView!

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
            md5Disp.text = textToHash.text.md5
            sha1Disp.text = textToHash.text.sha1
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
        if textView.text.utf16Count > 0 {
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

extension String  {
    var md5: String! {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
            let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
            let digestLen = Int(CC_MD5_DIGEST_LENGTH)
            let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
            
            CC_MD5(str!, strLen, result)
            
            var hash = NSMutableString()
            for i in 0..<digestLen {
                hash.appendFormat("%02x", result[i])
            }
            
            result.destroy()
            
            return String(format: hash)
    }
    
    var sha1: String! {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)!
        var digest = [UInt8](count:Int(CC_SHA1_DIGEST_LENGTH), repeatedValue: 0)
        CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
        let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
        for byte in digest {
            output.appendFormat("%02x", byte)
        }
        return output
    }
}