//
//  TextBase64ViewController.h
//  HexBT
//
//  Created by Pan Ziyue on 15/8/13.
//  Copyright (c) 2013 Pan Ziyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextBase64ViewController : UITableViewController <UITextViewDelegate>
{
    IBOutlet UITextView *textToBase64;
    IBOutlet UITextView *base64Disp;
}

@property (strong,nonatomic) IBOutlet UITextView *textToBase64;
@property (strong,nonatomic) IBOutlet UITextView *base64Disp;

- (NSString *)base64Encode:(NSString *)plainText;
- (NSString *)base64Decode:(NSString *)base64String;

-(IBAction)convert:(id)sender;
-(IBAction)convertBack:(id)sender;
-(IBAction)share:(id)sender;

@end
