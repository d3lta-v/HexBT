//
//  HexBTViewController.m
//  HexBT
//
//  Created by Pan Ziyue on 5/8/13.
//  Copyright (c) 2013 Pan Ziyue. All rights reserved.
//

#import "HexBTViewController.h"

@interface HexBTViewController ()

@end

@implementation HexBTViewController

@synthesize textToBinary;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)dismissKeyboard:(id)sender
{
    [textToBinary resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
