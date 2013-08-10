//
//  HashSumViewController.h
//  HexBT
//
//  Created by Pan Ziyue on 10/8/13.
//  Copyright (c) 2013 Pan Ziyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HashSumViewController : UITableViewController <UITextViewDelegate>
{
    IBOutlet UITextView *textToHash;
    IBOutlet UITextView *md5Disp;
    IBOutlet UITextView *sha1Disp;
}

@property (strong,nonatomic) IBOutlet UITextView *textToHash;
@property (strong,nonatomic) IBOutlet UITextView *md5Disp;
@property (strong,nonatomic) IBOutlet UITextView *sha1Disp;

-(NSString*)sha1:(NSString*)input;
-(NSString*)md5:(NSString*)input;

-(IBAction)convert:(id)sender;
-(IBAction)share:(id)sender;

@end
