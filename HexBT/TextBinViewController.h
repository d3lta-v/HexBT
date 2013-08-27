//
//  TextBinViewController.h
//  HexBT
//
//  Created by Pan Ziyue on 5/8/13.
//  Copyright (c) 2013 Pan Ziyue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCPlaceholderTextView.h"

@interface TextBinViewController : UITableViewController <UITextViewDelegate>
{
    IBOutlet GCPlaceholderTextView *textToBinary;
    IBOutlet GCPlaceholderTextView *binaryDisp;
}

@property (strong,nonatomic) IBOutlet GCPlaceholderTextView *textToBinary;
@property (strong,nonatomic) IBOutlet GCPlaceholderTextView *binaryDisp;

-(NSString *)textToBin:(NSString *)text;
-(NSString *)binToText:(NSString *)text;

-(IBAction)convert:(id)sender;
-(IBAction)convertBack:(id)sender;
-(IBAction)share:(id)sender;

@end
