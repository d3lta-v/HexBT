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
    TextBinViewController *binVC=[[TextBinViewController alloc]init];
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
    /*
    if ([binSet isEqualToString:@"0000"]) {
        hexR=[hexR stringByAppendingString:@"0"];
    }
    else if ([binSet isEqualToString:@"0001"]) {
        hexR=[hexR stringByAppendingString:@"1"];
    }
    else if ([binSet isEqualToString:@"0010"]) {
        hexR=[hexR stringByAppendingString:@"2"];
    }
    else if ([binSet isEqualToString:@"0011"]) {
        hexR=[hexR stringByAppendingString:@"3"];
    }
    else if ([binSet isEqualToString:@"0100"]) {
        hexR=[hexR stringByAppendingString:@"4"];
    }
    else if ([binSet isEqualToString:@"0101"]) {
        hexR=[hexR stringByAppendingString:@"5"];
    }
    else if ([binSet isEqualToString:@"0110"]) {
        hexR=[hexR stringByAppendingString:@"6"];
    }
    else if ([binSet isEqualToString:@"0111"]) {
        hexR=[hexR stringByAppendingString:@"7"];
    }
    else if ([binSet isEqualToString:@"1000"]) {
        hexR=[hexR stringByAppendingString:@"8"];
    }
    else if ([binSet isEqualToString:@"1001"]) {
        hexR=[hexR stringByAppendingString:@"9"];
    }
    else if ([binSet isEqualToString:@"1010"]) {
        hexR=[hexR stringByAppendingString:@"A"];
    }
    else if ([binSet isEqualToString:@"1011"]) {
        hexR=[hexR stringByAppendingString:@"B"];
    }
    else if ([binSet isEqualToString:@"1100"]) {
        hexR=[hexR stringByAppendingString:@"C"];
    }
    else if ([binSet isEqualToString:@"1101"]) {
        hexR=[hexR stringByAppendingString:@"D"];
    }
    else if ([binSet isEqualToString:@"1110"]) {
        hexR=[hexR stringByAppendingString:@"E"];
    }
    else if ([binSet isEqualToString:@"1111"]) {
        hexR=[hexR stringByAppendingString:@"F"];
    }*/
    
    return hexR;
}

-(IBAction)convert:(id)sender
{
    NSString *converted=[self textToHex:textToHex.text];
    hexDisp.text=converted;
    [textToHex resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    textToHex.clipsToBounds=YES;
    textToHex.layer.cornerRadius=10.0f;
    hexDisp.clipsToBounds=YES;
    hexDisp.layer.cornerRadius=10.0f;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
