//
//  TextBinViewController.m
//  HexBT
//
//  Created by Pan Ziyue on 5/8/13.
//  Copyright (c) 2013 Pan Ziyue. All rights reserved.
//

#import "TextBinViewController.h"
#import "MNNSStringWithUnichar.h"
#import <QuartzCore/QuartzCore.h>

@interface TextBinViewController ()

@end

@implementation TextBinViewController

@synthesize textToBinary, binaryDisp;

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Test, comment to disable
    //NSLog(@"%@",[self textToBin:@"ABCDEFGHIJKLMN"]);
    
    textToBinary.clipsToBounds=YES;
    textToBinary.layer.cornerRadius=10.0f;
    binaryDisp.clipsToBounds=YES;
    binaryDisp.layer.cornerRadius=10.0f;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    //Conversion engine CSIMUX (Convertor, aScIi, Mutable Unified X-over Engine)
    textView.delegate=self;
    [textView resignFirstResponder];
}

-(IBAction)convert:(id)sender
{
    NSString *converted=[self textToBin:textToBinary.text];
    binaryDisp.text=converted;
    [textToBinary resignFirstResponder];
}

-(IBAction)share:(id)sender
{
    if ([binaryDisp hasText]) {
        UIActivityViewController *actViewCtrl=[[UIActivityViewController alloc]initWithActivityItems:@[binaryDisp.text] applicationActivities:nil];
        [self presentViewController:actViewCtrl animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Nothing To Share!" message:nil delegate:nil cancelButtonTitle:@"Back" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(NSString *)textToBin:(NSString *)text
{
    NSString *value=[[NSString alloc]init]; //The alloc init is VERY IMPORTANT! It makes sure it's even properly present in the memory and not deallocated for no good reason
    NSString *strChar;
    bool blank=true;
    
    while (blank)
    {
        for (int x=0; x<text.length; x++)
        {
            strChar=[MNNSStringWithUnichar stringWithUnichar:[text characterAtIndex:x]];
            //For caps
            if ([strChar isEqualToString:@"A"]) { //For A
                value=[value stringByAppendingString:@"01000001"];
            }
            else if ([strChar isEqualToString:@"B"]) { //For B
                value=[value stringByAppendingString:@"01000010"];
            }
            else if ([strChar isEqualToString:@"C"]) { //For C
                value=[value stringByAppendingString:@"01000011"];
            }
            else if ([strChar isEqualToString:@"D"]) { 
                value=[value stringByAppendingString:@"01000100"];
            }
            else if ([strChar isEqualToString:@"E"]) { 
                value=[value stringByAppendingString:@"01000101"];
            }
            else if ([strChar isEqualToString:@"F"]) {
                value=[value stringByAppendingString:@"01000110"];
            }
            else if ([strChar isEqualToString:@"G"]) {
                value=[value stringByAppendingString:@"01000111"];
            }
            else if ([strChar isEqualToString:@"H"]) {
                value=[value stringByAppendingString:@"01001000"];
            }
            else if ([strChar isEqualToString:@"I"]) {
                value=[value stringByAppendingString:@"01001001"];
            }
            else if ([strChar isEqualToString:@"J"]) {
                value=[value stringByAppendingString:@"01001010"];
            }
            else if ([strChar isEqualToString:@"K"]) {
                value=[value stringByAppendingString:@"01001011"];
            }
            else if ([strChar isEqualToString:@"L"]) {
                value=[value stringByAppendingString:@"01001100"];
            }
            else if ([strChar isEqualToString:@"M"]) {
                value=[value stringByAppendingString:@"01001101"];
            }
            else if ([strChar isEqualToString:@"N"]) {
                value=[value stringByAppendingString:@"01001110"];
            }
            else if ([strChar isEqualToString:@"O"]) {
                value=[value stringByAppendingString:@"01001111"];
            }
            else if ([strChar isEqualToString:@"P"]) {
                value=[value stringByAppendingString:@"01010000"];
            }
            else if ([strChar isEqualToString:@"Q"]) {
                value=[value stringByAppendingString:@"01010001"];
            }
            else if ([strChar isEqualToString:@"R"]) {
                value=[value stringByAppendingString:@"01010010"];
            }
            else if ([strChar isEqualToString:@"S"]) {
                value=[value stringByAppendingString:@"01010011"];
            }
            else if ([strChar isEqualToString:@"T"]) {
                value=[value stringByAppendingString:@"01010100"];
            }
            else if ([strChar isEqualToString:@"U"]) {
                value=[value stringByAppendingString:@"01010101"];
            }
            else if ([strChar isEqualToString:@"V"]) {
                value=[value stringByAppendingString:@"01010110"];
            }
            else if ([strChar isEqualToString:@"W"]) {
                value=[value stringByAppendingString:@"01010111"];
            }
            else if ([strChar isEqualToString:@"X"]) {
                value=[value stringByAppendingString:@"01011000"];
            }
            else if ([strChar isEqualToString:@"Y"]) {
                value=[value stringByAppendingString:@"01011001"];
            }
            else if ([strChar isEqualToString:@"Z"]) {
                value=[value stringByAppendingString:@"01011010"];
            }
            //Now onto small case ones
            else if ([strChar isEqualToString:@"a"]) {
                value=[value stringByAppendingString:@"01100001"];
            }
            else if ([strChar isEqualToString:@"b"]) {
                value=[value stringByAppendingString:@"01100010"];
            }
            else if ([strChar isEqualToString:@"c"]) {
                value=[value stringByAppendingString:@"01100011"];
            }
            else if ([strChar isEqualToString:@"d"]) {
                value=[value stringByAppendingString:@"01100100"];
            }
            else if ([strChar isEqualToString:@"e"]) {
                value=[value stringByAppendingString:@"01100101"];
            }
            else if ([strChar isEqualToString:@"f"]) {
                value=[value stringByAppendingString:@"01100110"];
            }
            else if ([strChar isEqualToString:@"g"]) {
                value=[value stringByAppendingString:@"01100111"];
            }
            else if ([strChar isEqualToString:@"h"]) {
                value=[value stringByAppendingString:@"01101000"];
            }
            else if ([strChar isEqualToString:@"i"]) {
                value=[value stringByAppendingString:@"01101001"];
            }
            else if ([strChar isEqualToString:@"j"]) {
                value=[value stringByAppendingString:@"01101010"];
            }
            else if ([strChar isEqualToString:@"k"]) {
                value=[value stringByAppendingString:@"01101011"];
            }
            else if ([strChar isEqualToString:@"l"]) {
                value=[value stringByAppendingString:@"01101100"];
            }
            else if ([strChar isEqualToString:@"m"]) {
                value=[value stringByAppendingString:@"01101101"];
            }
            else if ([strChar isEqualToString:@"n"]) {
                value=[value stringByAppendingString:@"01101110"];
            }
            else if ([strChar isEqualToString:@"o"]) {
                value=[value stringByAppendingString:@"01101111"];
            }
            else if ([strChar isEqualToString:@"p"]) {
                value=[value stringByAppendingString:@"01110000"];
            }
            else if ([strChar isEqualToString:@"q"]) {
                value=[value stringByAppendingString:@"01110001"];
            }
            else if ([strChar isEqualToString:@"r"]) {
                value=[value stringByAppendingString:@"01110010"];
            }
            else if ([strChar isEqualToString:@"s"]) {
                value=[value stringByAppendingString:@"01110011"];
            }
            else if ([strChar isEqualToString:@"t"]) {
                value=[value stringByAppendingString:@"01110100"];
            }
            else if ([strChar isEqualToString:@"u"]) {
                value=[value stringByAppendingString:@"01110101"];
            }
            else if ([strChar isEqualToString:@"v"]) {
                value=[value stringByAppendingString:@"01110110"];
            }
            else if ([strChar isEqualToString:@"w"]) {
                value=[value stringByAppendingString:@"01110111"];
            }
            else if ([strChar isEqualToString:@"x"]) {
                value=[value stringByAppendingString:@"01111000"];
            }
            else if ([strChar isEqualToString:@"y"]) {
                value=[value stringByAppendingString:@"01111001"];
            }
            else if ([strChar isEqualToString:@"z"]) {
                value=[value stringByAppendingString:@"01111010"];
            }
            else if ([strChar isEqualToString:@" "]) {
                value=[value stringByAppendingString:@"00100000"];
            }
            else if ([strChar isEqualToString:@"1"]) {
                value=[value stringByAppendingString:@"00110001"];
            }
            else if ([strChar isEqualToString:@"2"]) {
                value=[value stringByAppendingString:@"00110010"];
            }
            else if ([strChar isEqualToString:@"3"]) {
                value=[value stringByAppendingString:@"00110010"];
            }
            else if ([strChar isEqualToString:@"4"]) {
                value=[value stringByAppendingString:@"00110100"];
            }
            else if ([strChar isEqualToString:@"5"]) {
                value=[value stringByAppendingString:@"00110101"];
            }
            else if ([strChar isEqualToString:@"6"]) {
                value=[value stringByAppendingString:@"00110110"];
            }
            else if ([strChar isEqualToString:@"7"]) {
                value=[value stringByAppendingString:@"00110111"];
            }
            else if ([strChar isEqualToString:@"8"]) {
                value=[value stringByAppendingString:@"00111000"];
            }
            else if ([strChar isEqualToString:@"9"]) {
                value=[value stringByAppendingString:@"00111001"];
            }
            else if ([strChar isEqualToString:@"0"]) {
                value=[value stringByAppendingString:@"00110000"];
            }
            else if ([strChar isEqualToString:@"-"]) {
                value=[value stringByAppendingString:@"00101101"];
            }
            else if ([strChar isEqualToString:@"/"]) {
                value=[value stringByAppendingString:@"00101111"];
            }
            else if ([strChar isEqualToString:@":"]) {
                value=[value stringByAppendingString:@"00111010"];
            }
            else if ([strChar isEqualToString:@";"]) {
                value=[value stringByAppendingString:@"00111011"];
            }
            else if ([strChar isEqualToString:@"("])
            {
                value=[value stringByAppendingString:@"00101000"];
            }
            else if ([strChar isEqualToString:@")"])
            {
                value=[value stringByAppendingString:@"00101001"];
            }
            else if ([strChar isEqualToString:@"$"])
            {
                value=[value stringByAppendingString:@"00100100"];
            }
            else if ([strChar isEqualToString:@"&"])
            {
                value=[value stringByAppendingString:@"00100110"];
            }
            else if ([strChar isEqualToString:@"@"])
            {
                value=[value stringByAppendingString:@"01000000"];
            }
            else if ([strChar isEqualToString:@"\""]) //The " character needs escaping
            {
                value=[value stringByAppendingString:@"00100010"];
            }
            else if ([strChar isEqualToString:@"."])
            {
                value=[value stringByAppendingString:@"00101110"];
            }
            else if ([strChar isEqualToString:@","])
            {
                value=[value stringByAppendingString:@"00101100"];
            }
            else if ([strChar isEqualToString:@"?"])
            {
                value=[value stringByAppendingString:@"00111111"];
            }
            else if ([strChar isEqualToString:@"!"])
            {
                value=[value stringByAppendingString:@"00100001"];
            }
            else if ([strChar isEqualToString:@"'"])
            {
                value=[value stringByAppendingString:@"00100001"];
            }
            else if ([strChar isEqualToString:@"["])
            {
                value=[value stringByAppendingString:@"01011011"];
            }
            else if ([strChar isEqualToString:@"]"])
            {
                value=[value stringByAppendingString:@"01011101"];
            }
            else if ([strChar isEqualToString:@"{"])
            {
                value=[value stringByAppendingString:@"01111011"];
            }
            else if ([strChar isEqualToString:@"}"])
            {
                value=[value stringByAppendingString:@"01111101"];
            }
            else if ([strChar isEqualToString:@"#"])
            {
                value=[value stringByAppendingString:@"00100011"];
            }
            else if ([strChar isEqualToString:@"\%"])
            {
                value=[value stringByAppendingString:@"00100101"];
            }
            else if ([strChar isEqualToString:@"^"])
            {
                value=[value stringByAppendingString:@"01011110"];
            }
            else if ([strChar isEqualToString:@"*"])
            {
                value=[value stringByAppendingString:@"00101010"];
            }
            else if ([strChar isEqualToString:@"+"])
            {
                value=[value stringByAppendingString:@"00101011"];
            }
            else if ([strChar isEqualToString:@"="])
            {
                value=[value stringByAppendingString:@"00111101"];
            }
            else if ([strChar isEqualToString:@"_"])
            {
                value=[value stringByAppendingString:@"01011111"];
            }
            else if ([strChar isEqualToString:@"\\"])
            {
                value=[value stringByAppendingString:@"01011100"];
            }
            else if ([strChar isEqualToString:@"|"])
            {
                value=[value stringByAppendingString:@"01111100"];
            }
            else if ([strChar isEqualToString:@"~"])
            {
                value=[value stringByAppendingString:@"01111110"];
            }
            else if ([strChar isEqualToString:@"<"])
            {
                value=[value stringByAppendingString:@"00111100"];
            }
            else if ([strChar isEqualToString:@">"])
            {
                value=[value stringByAppendingString:@"00111110"];
            }
            else if ([strChar isEqualToString:@"£"])
            {
                value=[value stringByAppendingString:@"10011100"];
            }
            else if ([strChar isEqualToString:@"¥"])
            {
                value=[value stringByAppendingString:@"10011101"];
            }
            else if ([strChar isEqualToString:@"•"])
            {
                value=[value stringByAppendingString:@"11111001"];
            }
            else if ([strChar isEqualToString:@"€"])
            {
                value=[value stringByAppendingString:@"10000000"];
            }
            else
            {
                value=@"Invalid input, no non-ASCII characters are allowed";
                blank=false;
            }
        }
        blank=false;
    }
    return value;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
