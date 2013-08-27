//
//  TextHexViewController.h
//  HexBT
//
//  Created by Pan Ziyue on 9/8/13.
//  Copyright (c) 2013 Pan Ziyue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCPlaceholderTextView.h"

@interface TextHexViewController : UITableViewController <UITextViewDelegate>
{
    IBOutlet GCPlaceholderTextView *textToHex;
    IBOutlet GCPlaceholderTextView *hexDisp;
}

@property (strong,nonatomic) IBOutlet GCPlaceholderTextView *textToHex;
@property (strong,nonatomic) IBOutlet GCPlaceholderTextView *hexDisp;

-(NSString *)textToHex:(NSString *)text;
-(NSString *)hexToText:(NSString *)text;

-(IBAction)convert:(id)sender;
-(IBAction)convertBack:(id)sender;
-(IBAction)share:(id)sender;

@end
