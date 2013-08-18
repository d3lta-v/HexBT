//
//  TextBase64ViewController.m
//  HexBT
//
//  Created by Pan Ziyue on 15/8/13.
//  Copyright (c) 2013 Pan Ziyue. All rights reserved.
//

#import "TextBase64ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "NSData+Base64.h"
#import "SVProgressHUD.h"
#import "WCAlertView.h"

@interface TextBase64ViewController ()

@end

@implementation TextBase64ViewController

@synthesize textToBase64, base64Disp;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    textToBase64.clipsToBounds=YES;
    textToBase64.layer.cornerRadius=10.0f;
    base64Disp.clipsToBounds=YES;
    base64Disp.layer.cornerRadius=10.0f;
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor=[UIColor colorWithWhite:0.95 alpha:1];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [swipeDown setDirection:(UISwipeGestureRecognizerDirectionDown)];
    
    [[self view] addGestureRecognizer:swipeDown];
}
-(void)dismissKeyboard
{
    [textToBase64 resignFirstResponder];
    [base64Disp resignFirstResponder];
}

- (NSString *)base64Encode:(NSString *)plainText
{
    NSData *plainTextData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainTextData base64EncodedString];
    return base64String;
}

- (NSString *)base64Decode:(NSString *)base64String
{
    NSData *plainTextData = [NSData dataFromBase64String:base64String];
    NSString *plainText = [[NSString alloc] initWithData:plainTextData encoding:NSUTF8StringEncoding];
    if ([plainText length] == 0) {
        WCAlertView *alert=[[WCAlertView alloc]initWithTitle:@"[ERROR] Invalid or no text!" message:nil delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
        textToBase64.text=@"";
    }
    return plainText;
}

-(IBAction)convertBack:(id)sender
{
    textToBase64.text=[self base64Decode:base64Disp.text];
    [base64Disp resignFirstResponder];
}

-(IBAction)share:(id)sender
{
    if ([base64Disp hasText]) {
        [SVProgressHUD showWithStatus:@"Loading..."];
        double delayInSeconds = 0.1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            UIActivityViewController *actViewCtrl=[[UIActivityViewController alloc]initWithActivityItems:@[base64Disp.text] applicationActivities:nil];
            [self presentViewController:actViewCtrl animated:YES completion:^(void){
                [SVProgressHUD dismiss];
            }];
        });
    }
    else
    {
        WCAlertView *alert=[[WCAlertView alloc]initWithTitle:@"Nothing To Share!" message:nil delegate:nil cancelButtonTitle:@"Back" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(IBAction)convert:(id)sender
{
    if ([textToBase64 hasText]) {
        NSString *converted=[self base64Encode:textToBase64.text];
        base64Disp.text=converted;
        [textToBase64 resignFirstResponder];
        
    }
    else if (![base64Disp hasText]||![textToBase64 hasText])
    {
        WCAlertView *alert=[[WCAlertView alloc]initWithTitle:@"[ERROR] Invalid or no text!" message:nil delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
        base64Disp.text=@"";
        [textToBase64 resignFirstResponder];
    }
    else
    {
        [textToBase64 resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
