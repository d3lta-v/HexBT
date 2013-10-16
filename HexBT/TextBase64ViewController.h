//
//  TextBase64ViewController.h
//  HexBT
//
//  Created by Pan Ziyue on 15/8/13.
//  Copyright (c) 2013 Pan Ziyue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCPlaceholderTextView.h"

@interface TextBase64ViewController : UITableViewController <UITextViewDelegate>
{
    IBOutlet GCPlaceholderTextView *textToBase64;
    IBOutlet GCPlaceholderTextView *base64Disp;
}

@property (strong,nonatomic) IBOutlet GCPlaceholderTextView *textToBase64;
@property (strong,nonatomic) IBOutlet GCPlaceholderTextView *base64Disp;

- (NSString *)base64Encode:(NSString *)plainText;
- (NSString *)base64Decode:(NSString *)base64String;

-(IBAction)convert:(id)sender;
-(IBAction)share:(id)sender;

@end
