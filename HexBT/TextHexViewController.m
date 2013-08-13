//
//  TextHexViewController.m
//  HexBT
//
//  Created by Pan Ziyue on 9/8/13.
//  Copyright (c) 2013 Pan Ziyue. All rights reserved.
//

#import "TextHexViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MNNSStringWithUnichar.h"
#import "TextBinViewController.h"

@interface TextHexViewController ()

@end

@implementation TextHexViewController

@synthesize textToHex,hexDisp;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    //Conversion engine CSIMUX (Convertor, aScIi, Mutable Unified X-over Engine)
    textView.delegate=self;
    [textView resignFirstResponder];
}

-(NSString *)textToHex:(NSString *)text
{
    //The CSIMUX converter
    TextBinViewController *binVC=[[TextBinViewController alloc]init]; //This requires the binary converter to be active
    NSString *toBeConverted=[binVC textToBin:text];
    
    int sets=toBeConverted.length/4;
    NSString *hexR=[[NSString alloc]init];
    bool blank=true;
    NSString *binSet=[[NSString alloc]init];
    NSString *binSet1;
    NSString *binSet2;
    NSString *binSet3;
    NSString *binSet4;
    
    while (blank) {
        if (sets%1==0) {
            for (int x=0; x<sets; x++) {
                binSet1=[MNNSStringWithUnichar stringWithUnichar:[toBeConverted characterAtIndex:x*4]];
                binSet2=[MNNSStringWithUnichar stringWithUnichar:[toBeConverted characterAtIndex:x*4+1]];
                binSet3=[MNNSStringWithUnichar stringWithUnichar:[toBeConverted characterAtIndex:x*4+2]];
                binSet4=[MNNSStringWithUnichar stringWithUnichar:[toBeConverted characterAtIndex:x*4+3]];
                binSet=[binSet stringByAppendingString:binSet1];
                binSet=[binSet stringByAppendingString:binSet2];
                binSet=[binSet stringByAppendingString:binSet3];
                binSet=[binSet stringByAppendingString:binSet4];
                binSet=[binSet stringByAppendingString:@"/"];
                
                blank=false;
            }
        }
        else
        {
            blank=false;
        }
    }
    NSArray *binArray=[binSet componentsSeparatedByString:@"/"];
    for (int x=0; x<[binArray count]; x++) {
        if ([binArray[x] isEqualToString:@"0000"]) {
            hexR=[hexR stringByAppendingString:@"0"];
        }
        else if ([binArray[x] isEqualToString:@"0001"]) {
            hexR=[hexR stringByAppendingString:@"1"];
        }
        else if ([binArray[x] isEqualToString:@"0010"]) {
            hexR=[hexR stringByAppendingString:@"2"];
        }
        else if ([binArray[x] isEqualToString:@"0011"]) {
            hexR=[hexR stringByAppendingString:@"3"];
        }
        else if ([binArray[x] isEqualToString:@"0100"]) {
            hexR=[hexR stringByAppendingString:@"4"];
        }
        else if ([binArray[x] isEqualToString:@"0101"]) {
            hexR=[hexR stringByAppendingString:@"5"];
        }
        else if ([binArray[x] isEqualToString:@"0110"]) {
            hexR=[hexR stringByAppendingString:@"6"];
        }
        else if ([binArray[x] isEqualToString:@"0111"]) {
            hexR=[hexR stringByAppendingString:@"7"];
        }
        else if ([binArray[x] isEqualToString:@"1000"]) {
            hexR=[hexR stringByAppendingString:@"8"];
        }
        else if ([binArray[x] isEqualToString:@"1001"]) {
            hexR=[hexR stringByAppendingString:@"9"];
        }
        else if ([binArray[x] isEqualToString:@"1010"]) {
            hexR=[hexR stringByAppendingString:@"A"];
        }
        else if ([binArray[x] isEqualToString:@"1011"]) {
            hexR=[hexR stringByAppendingString:@"B"];
        }
        else if ([binArray[x] isEqualToString:@"1100"]) {
            hexR=[hexR stringByAppendingString:@"C"];
        }
        else if ([binArray[x] isEqualToString:@"1101"]) {
            hexR=[hexR stringByAppendingString:@"D"];
        }
        else if ([binArray[x] isEqualToString:@"1110"]) {
            hexR=[hexR stringByAppendingString:@"E"];
        }
        else if ([binArray[x] isEqualToString:@"1111"]) {
            hexR=[hexR stringByAppendingString:@"F"];
        }
    }
    return hexR;
}

-(NSString *)hexToText:(NSString *)text
{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    for (int i=0; i<text.length; i++) {
        [array addObject:[MNNSStringWithUnichar stringWithUnichar:[text characterAtIndex:i]]];
    }
    NSString *binary=[[NSString alloc]init];
    for (int x=0; x<[array count]; x++) {
        if ([array[x] isEqualToString:@"0"]) {
            binary=[binary stringByAppendingString:@"0000"];
        }
        else if ([array[x] isEqualToString:@"1"]) {
            binary=[binary stringByAppendingString:@"0001"];
        }
        else if ([array[x] isEqualToString:@"2"]) {
            binary=[binary stringByAppendingString:@"0010"];
        }
        else if ([array[x] isEqualToString:@"3"]) {
            binary=[binary stringByAppendingString:@"0011"];
        }
        else if ([array[x] isEqualToString:@"4"]) {
            binary=[binary stringByAppendingString:@"0100"];
        }
        else if ([array[x] isEqualToString:@"5"]) {
            binary=[binary stringByAppendingString:@"0101"];
        }
        else if ([array[x] isEqualToString:@"6"]) {
            binary=[binary stringByAppendingString:@"0110"];
        }
        else if ([array[x] isEqualToString:@"7"]) {
            binary=[binary stringByAppendingString:@"0111"];
        }
        else if ([array[x] isEqualToString:@"8"]) {
            binary=[binary stringByAppendingString:@"1000"];
        }
        else if ([array[x] isEqualToString:@"9"]) {
            binary=[binary stringByAppendingString:@"1001"];
        }
        else if ([array[x] isEqualToString:@"A"]) {
            binary=[binary stringByAppendingString:@"1010"];
        }
        else if ([array[x] isEqualToString:@"B"]) {
            binary=[binary stringByAppendingString:@"1011"];
        }
        else if ([array[x] isEqualToString:@"C"]) {
            binary=[binary stringByAppendingString:@"1100"];
        }
        else if ([array[x] isEqualToString:@"D"]) {
            binary=[binary stringByAppendingString:@"1101"];
        }
        else if ([array[x] isEqualToString:@"E"]) {
            binary=[binary stringByAppendingString:@"1110"];
        }
        else if ([array[x] isEqualToString:@"F"]) {
            binary=[binary stringByAppendingString:@"1111"];
        }
    }
    TextBinViewController *binVC=[[TextBinViewController alloc]init];
    return [binVC binToText:binary];
}

-(IBAction)convertBack:(id)sender
{
    textToHex.text=[self hexToText:hexDisp.text];
    [hexDisp resignFirstResponder];
}

-(IBAction)share:(id)sender
{
    if ([hexDisp hasText]) {
        UIActivityViewController *actViewCtrl=[[UIActivityViewController alloc]initWithActivityItems:@[hexDisp.text] applicationActivities:nil];
        [self presentViewController:actViewCtrl animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Nothing To Share!" message:nil delegate:nil cancelButtonTitle:@"Back" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(IBAction)convert:(id)sender
{
    if ([textToHex hasText]) {
        NSString *converted=[self textToHex:textToHex.text];
        hexDisp.text=converted;
        [textToHex resignFirstResponder];
        
    }
    else if (![hexDisp hasText]||![textToHex hasText])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"[ERROR] Invalid or no text!" message:nil delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
        hexDisp.text=@"";
        [textToHex resignFirstResponder];
    }
    else
    {
        [textToHex resignFirstResponder];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    textToHex.clipsToBounds=YES;
    textToHex.layer.cornerRadius=10.0f;
    hexDisp.clipsToBounds=YES;
    hexDisp.layer.cornerRadius=10.0f;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [textToHex resignFirstResponder];
    [hexDisp resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
