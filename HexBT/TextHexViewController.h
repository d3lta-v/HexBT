//
//  TextHexViewController.h
//  HexBT
//
//  Created by Pan Ziyue on 9/8/13.
//  Copyright (c) 2013 Pan Ziyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextHexViewController : UITableViewController <UITextViewDelegate>
{
    IBOutlet UITextView *textToHex;
    IBOutlet UITextView *hexDisp;
}

@property (strong,nonatomic) IBOutlet UITextView *textToHex;
@property (strong,nonatomic) IBOutlet UITextView *hexDisp;

-(NSString *)textToHex:(NSString *)text;

-(IBAction)convert:(id)sender;
-(IBAction)share:(id)sender;

@end
