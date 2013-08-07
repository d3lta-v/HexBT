//
//  HexBTViewController.h
//  HexBT
//
//  Created by Pan Ziyue on 5/8/13.
//  Copyright (c) 2013 Pan Ziyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HexBTViewController : UIViewController
{
    IBOutlet UITextField *textToBinary;
}

@property (strong,nonatomic) IBOutlet UITextField *textToBinary;

-(IBAction)dismissKeyboard:(id)sender;

@end
