//
//  TextBinViewController.h
//  HexBT
//
//  Created by Pan Ziyue on 5/8/13.
//  Copyright (c) 2013 Pan Ziyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextBinViewController : UITableViewController <UITextViewDelegate>
{
    IBOutlet UITextView *textToBinary;
    IBOutlet UITextView *binaryDisp;
}

@property (strong,nonatomic) IBOutlet UITextView *textToBinary;
@property (strong,nonatomic) IBOutlet UITextView *binaryDisp;

-(NSString *)textToBin:(NSString *)text;

-(IBAction)convert:(id)sender;
-(IBAction)share:(id)sender;

@end
