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
#import "SVProgressHUD.h"

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
    
    //Set tab bar icons again, since the tutorial messes up the custom tab bars (for some reason)
    UITabBar *tabBar = self.tabBarController.tabBar;
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    UITabBarItem *item3 = [tabBar.items objectAtIndex:3];
    UITabBarItem *item4 = [tabBar.items objectAtIndex:4];
    [item0 setFinishedSelectedImage:[UIImage imageNamed:@"TextToBin_Selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"TextToBin_Deselected"]];
    [item1 setFinishedSelectedImage:[UIImage imageNamed:@"TextToHex_Selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"TextToHex_Deselected.png"]];
    [item2 setFinishedSelectedImage:[UIImage imageNamed:@"TextToBase64_Selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"TextToBase64_Deselected.png"]];
    [item3 setFinishedSelectedImage:[UIImage imageNamed:@"Hash_Selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"Hash_Deselected.png"]];
#warning CHANGE THE IMAGES IN FINAL PRODUCT
    [item4 setFinishedSelectedImage:[UIImage imageNamed:@"Info_Button_Selected"] withFinishedUnselectedImage:[UIImage imageNamed:@"Info_Button_Deselected"]];
    
    // Makes the text fields rounded
    textToBinary.clipsToBounds=YES;
    textToBinary.layer.cornerRadius=10.0f;
    textToBinary.placeholder=@"Input text here";
    binaryDisp.clipsToBounds=YES;
    binaryDisp.layer.cornerRadius=10.0f;
    binaryDisp.placeholder=@"Output binary here";
    
    // Sets the colors of the background
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor=[UIColor colorWithWhite:0.95 alpha:1];
    
    //Set navigation bar looks
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.alpha = 0.9f;
    self.navigationController.navigationBar.translucent = YES;
    
    //Set title text attributes
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:49.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1.0];
    label.text = @"Text to Binary Converter";
    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
    [label setShadowColor:[UIColor whiteColor]];
    [label setShadowOffset:CGSizeMake(0, -0.5)];
    self.navigationItem.titleView = label;
    
    // Adds action to tap & dismiss keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    // Adds action to swipe down & dismiss keyboard
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [swipeDown setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [[self view] addGestureRecognizer:swipeDown];
    
    //Checking if user is first run
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if (! [defaults boolForKey:@"notFirstRun"]) {
        
        double delayInSeconds = 0.1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self performSegueWithIdentifier:@"Tutorial" sender:self];
        });
        [defaults setBool:YES forKey:@"notFirstRun"];
    }
    else
    {
        return;
    }
}

-(void)dismissKeyboard {
    [textToBinary resignFirstResponder];
    [binaryDisp resignFirstResponder];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    //Conversion engine CSIMUX (Convertor, aScIi, Mutable Unified X-over Engine)
    textView.delegate=self;
    [textView resignFirstResponder];
}

-(IBAction)convert:(id)sender
{
    if ([textToBinary hasText]) {
        NSString *converted=[self textToBin:textToBinary.text];
        binaryDisp.text=converted;
        [textToBinary resignFirstResponder];
    }
    else if (![textToBinary hasText]||![binaryDisp hasText])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error: Invalid or no text!" message:nil delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
        binaryDisp.text=@"";
    }
    else
    {
        [textToBinary resignFirstResponder];
    }
}

-(IBAction)convertBack:(id)sender
{
    if ([binaryDisp hasText]) {
        NSString *converted=[self binToText:binaryDisp.text];
        textToBinary.text=converted;
        [binaryDisp resignFirstResponder];
    }
    else if (![textToBinary hasText]||![binaryDisp hasText])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error: Invalid or no text!" message:nil delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
        textToBinary.text=@"";
    }
    else
    {
        [binaryDisp resignFirstResponder];
    }
}

-(IBAction)share:(id)sender
{
    if ([binaryDisp hasText]) {
        [SVProgressHUD showWithStatus:@"Loading..."];
        double delayInSeconds = 0.1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            UIActivityViewController *actViewCtrl=[[UIActivityViewController alloc]initWithActivityItems:@[binaryDisp.text] applicationActivities:nil];
            [self presentViewController:actViewCtrl animated:YES completion:^(void){
                [SVProgressHUD dismiss];
            }];
        });
    }
    else
    {
        UIAlertView
        *alert=[[UIAlertView alloc]initWithTitle:@"Nothing To Share!" message:nil delegate:nil cancelButtonTitle:@"Back" otherButtonTitles:nil, nil];
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
            else if ([strChar isEqualToString:@"\n"])
            {
                value=[value stringByAppendingString:@"00001010"];
            }
            else
            {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error: Invalid input, no non-ASCII characters are allowed" message:nil delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                [alert show];
                value=@"";
                blank=false;
            }
            
        }
        blank=false;
    }
    return value;
}

-(NSString *)binToText:(NSString *)text
{
    NSString *value=[[NSString alloc]init];
    NSString *strChar;
    
    NSMutableArray *array=[[NSMutableArray alloc]init];
    if (text.length%8==0) {
        for (int i=0; i<text.length; i++) {
            if (i%8==0) {
                NSString *ch = [text substringWithRange:NSMakeRange(i, 8)];
                [array addObject:ch];
            }
        }
    }
    else
    {
        value=@"";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error: Invalid input!" message:nil delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    bool blank=true;
    
    while (blank)
    {
        for (int x=0; x<[array count]; x++)
        {
            strChar=array[x];
            //For caps
            if ([strChar isEqualToString:@"01000001"]) { //For A
                value=[value stringByAppendingString:@"A"];
            }
            else if ([strChar isEqualToString:@"01000010"]) { //For B
                value=[value stringByAppendingString:@"B"];
            }
            else if ([strChar isEqualToString:@"01000011"]) { //For C
                value=[value stringByAppendingString:@"C"];
            }
            else if ([strChar isEqualToString:@"01000100"]) {
                value=[value stringByAppendingString:@"D"];
            }
            else if ([strChar isEqualToString:@"01000101"]) {
                value=[value stringByAppendingString:@"E"];
            }
            else if ([strChar isEqualToString:@"01000110"]) {
                value=[value stringByAppendingString:@"F"];
            }
            else if ([strChar isEqualToString:@"01000111"]) {
                value=[value stringByAppendingString:@"G"];
            }
            else if ([strChar isEqualToString:@"01001000"]) {
                value=[value stringByAppendingString:@"H"];
            }
            else if ([strChar isEqualToString:@"01001001"]) {
                value=[value stringByAppendingString:@"I"];
            }
            else if ([strChar isEqualToString:@"01001010"]) {
                value=[value stringByAppendingString:@"J"];
            }
            else if ([strChar isEqualToString:@"01001011"]) {
                value=[value stringByAppendingString:@"K"];
            }
            else if ([strChar isEqualToString:@"01001100"]) {
                value=[value stringByAppendingString:@"L"];
            }
            else if ([strChar isEqualToString:@"01001101"]) {
                value=[value stringByAppendingString:@"M"];
            }
            else if ([strChar isEqualToString:@"01001110"]) {
                value=[value stringByAppendingString:@"N"];
            }
            else if ([strChar isEqualToString:@"01001111"]) {
                value=[value stringByAppendingString:@"O"];
            }
            else if ([strChar isEqualToString:@"01010000"]) {
                value=[value stringByAppendingString:@"P"];
            }
            else if ([strChar isEqualToString:@"01010001"]) {
                value=[value stringByAppendingString:@"Q"];
            }
            else if ([strChar isEqualToString:@"01010010"]) {
                value=[value stringByAppendingString:@"R"];
            }
            else if ([strChar isEqualToString:@"01010011"]) {
                value=[value stringByAppendingString:@"S"];
            }
            else if ([strChar isEqualToString:@"01010100"]) {
                value=[value stringByAppendingString:@"T"];
            }
            else if ([strChar isEqualToString:@"01010101"]) {
                value=[value stringByAppendingString:@"U"];
            }
            else if ([strChar isEqualToString:@"01010110"]) {
                value=[value stringByAppendingString:@"V"];
            }
            else if ([strChar isEqualToString:@"01010111"]) {
                value=[value stringByAppendingString:@"W"];
            }
            else if ([strChar isEqualToString:@"01011000"]) {
                value=[value stringByAppendingString:@"X"];
            }
            else if ([strChar isEqualToString:@"01011001"]) {
                value=[value stringByAppendingString:@"Y"];
            }
            else if ([strChar isEqualToString:@"01011010"]) {
                value=[value stringByAppendingString:@"Z"];
            }
            //Now onto small case ones
            else if ([strChar isEqualToString:@"01100001"]) {
                value=[value stringByAppendingString:@"a"];
            }
            else if ([strChar isEqualToString:@"01100010"]) {
                value=[value stringByAppendingString:@"b"];
            }
            else if ([strChar isEqualToString:@"01100011"]) {
                value=[value stringByAppendingString:@"c"];
            }
            else if ([strChar isEqualToString:@"01100100"]) {
                value=[value stringByAppendingString:@"d"];
            }
            else if ([strChar isEqualToString:@"01100101"]) {
                value=[value stringByAppendingString:@"e"];
            }
            else if ([strChar isEqualToString:@"01100110"]) {
                value=[value stringByAppendingString:@"f"];
            }
            else if ([strChar isEqualToString:@"01100111"]) {
                value=[value stringByAppendingString:@"g"];
            }
            else if ([strChar isEqualToString:@"01101000"]) {
                value=[value stringByAppendingString:@"h"];
            }
            else if ([strChar isEqualToString:@"01101001"]) {
                value=[value stringByAppendingString:@"i"];
            }
            else if ([strChar isEqualToString:@"01101010"]) {
                value=[value stringByAppendingString:@"j"];
            }
            else if ([strChar isEqualToString:@"01101011"]) {
                value=[value stringByAppendingString:@"k"];
            }
            else if ([strChar isEqualToString:@"01101100"]) {
                value=[value stringByAppendingString:@"l"];
            }
            else if ([strChar isEqualToString:@"01101101"]) {
                value=[value stringByAppendingString:@"m"];
            }
            else if ([strChar isEqualToString:@"01101110"]) {
                value=[value stringByAppendingString:@"n"];
            }
            else if ([strChar isEqualToString:@"01101111"]) {
                value=[value stringByAppendingString:@"o"];
            }
            else if ([strChar isEqualToString:@"01110000"]) {
                value=[value stringByAppendingString:@"p"];
            }
            else if ([strChar isEqualToString:@"01110001"]) {
                value=[value stringByAppendingString:@"q"];
            }
            else if ([strChar isEqualToString:@"01110010"]) {
                value=[value stringByAppendingString:@"r"];
            }
            else if ([strChar isEqualToString:@"01110011"]) {
                value=[value stringByAppendingString:@"s"];
            }
            else if ([strChar isEqualToString:@"01110100"]) {
                value=[value stringByAppendingString:@"t"];
            }
            else if ([strChar isEqualToString:@"01110101"]) {
                value=[value stringByAppendingString:@"u"];
            }
            else if ([strChar isEqualToString:@"01110110"]) {
                value=[value stringByAppendingString:@"v"];
            }
            else if ([strChar isEqualToString:@"01110111"]) {
                value=[value stringByAppendingString:@"w"];
            }
            else if ([strChar isEqualToString:@"01111000"]) {
                value=[value stringByAppendingString:@"x"];
            }
            else if ([strChar isEqualToString:@"01111001"]) {
                value=[value stringByAppendingString:@"y"];
            }
            else if ([strChar isEqualToString:@"01111010"]) {
                value=[value stringByAppendingString:@"z"];
            }
            else if ([strChar isEqualToString:@"00100000"]) {
                value=[value stringByAppendingString:@" "];
            }
            else if ([strChar isEqualToString:@"00110001"]) {
                value=[value stringByAppendingString:@"1"];
            }
            else if ([strChar isEqualToString:@"00110010"]) {
                value=[value stringByAppendingString:@"2"];
            }
            else if ([strChar isEqualToString:@"00110010"]) {
                value=[value stringByAppendingString:@"3"];
            }
            else if ([strChar isEqualToString:@"00110100"]) {
                value=[value stringByAppendingString:@"4"];
            }
            else if ([strChar isEqualToString:@"00110101"]) {
                value=[value stringByAppendingString:@"5"];
            }
            else if ([strChar isEqualToString:@"00110110"]) {
                value=[value stringByAppendingString:@"6"];
            }
            else if ([strChar isEqualToString:@"00110111"]) {
                value=[value stringByAppendingString:@"7"];
            }
            else if ([strChar isEqualToString:@"00111000"]) {
                value=[value stringByAppendingString:@"8"];
            }
            else if ([strChar isEqualToString:@"00111001"]) {
                value=[value stringByAppendingString:@"9"];
            }
            else if ([strChar isEqualToString:@"00110000"]) {
                value=[value stringByAppendingString:@"0"];
            }
            else if ([strChar isEqualToString:@"00101101"]) {
                value=[value stringByAppendingString:@"-"];
            }
            else if ([strChar isEqualToString:@"00101111"]) {
                value=[value stringByAppendingString:@"/"];
            }
            else if ([strChar isEqualToString:@"00111010"]) {
                value=[value stringByAppendingString:@":"];
            }
            else if ([strChar isEqualToString:@"00111011"]) {
                value=[value stringByAppendingString:@";"];
            }
            else if ([strChar isEqualToString:@"00101000"])
            {
                value=[value stringByAppendingString:@"("];
            }
            else if ([strChar isEqualToString:@"00101001"])
            {
                value=[value stringByAppendingString:@")"];
            }
            else if ([strChar isEqualToString:@"00100100"])
            {
                value=[value stringByAppendingString:@"$"];
            }
            else if ([strChar isEqualToString:@"00100110"])
            {
                value=[value stringByAppendingString:@"&"];
            }
            else if ([strChar isEqualToString:@"01000000"])
            {
                value=[value stringByAppendingString:@"@"];
            }
            else if ([strChar isEqualToString:@"00100010"]) //The " character needs escaping
            {
                value=[value stringByAppendingString:@"\""];
            }
            else if ([strChar isEqualToString:@"00101110"])
            {
                value=[value stringByAppendingString:@"."];
            }
            else if ([strChar isEqualToString:@"00101100"])
            {
                value=[value stringByAppendingString:@","];
            }
            else if ([strChar isEqualToString:@"00111111"])
            {
                value=[value stringByAppendingString:@"?"];
            }
            else if ([strChar isEqualToString:@"00100001"])
            {
                value=[value stringByAppendingString:@"!"];
            }
            else if ([strChar isEqualToString:@"00100111"])
            {
                value=[value stringByAppendingString:@"'"];
            }
            else if ([strChar isEqualToString:@"01011011"])
            {
                value=[value stringByAppendingString:@"["];
            }
            else if ([strChar isEqualToString:@"01011101"])
            {
                value=[value stringByAppendingString:@"]"];
            }
            else if ([strChar isEqualToString:@"01111011"])
            {
                value=[value stringByAppendingString:@"{"];
            }
            else if ([strChar isEqualToString:@"01111101"])
            {
                value=[value stringByAppendingString:@"}"];
            }
            else if ([strChar isEqualToString:@"00100011"])
            {
                value=[value stringByAppendingString:@"#"];
            }
            else if ([strChar isEqualToString:@"00100101"])
            {
                value=[value stringByAppendingString:@"\%"];
            }
            else if ([strChar isEqualToString:@"01011110"])
            {
                value=[value stringByAppendingString:@"^"];
            }
            else if ([strChar isEqualToString:@"00101010"])
            {
                value=[value stringByAppendingString:@"*"];
            }
            else if ([strChar isEqualToString:@"00101011"])
            {
                value=[value stringByAppendingString:@"+"];
            }
            else if ([strChar isEqualToString:@"00111101"])
            {
                value=[value stringByAppendingString:@"="];
            }
            else if ([strChar isEqualToString:@"01011111"])
            {
                value=[value stringByAppendingString:@"_"];
            }
            else if ([strChar isEqualToString:@"01011100"])
            {
                value=[value stringByAppendingString:@"\\"];
            }
            else if ([strChar isEqualToString:@"01111100"])
            {
                value=[value stringByAppendingString:@"|"];
            }
            else if ([strChar isEqualToString:@"01111110"])
            {
                value=[value stringByAppendingString:@"~"];
            }
            else if ([strChar isEqualToString:@"00111100"])
            {
                value=[value stringByAppendingString:@"<"];
            }
            else if ([strChar isEqualToString:@"00111110"])
            {
                value=[value stringByAppendingString:@">"];
            }
            else if ([strChar isEqualToString:@"10011100"])
            {
                value=[value stringByAppendingString:@"£"];
            }
            else if ([strChar isEqualToString:@"10011101"])
            {
                value=[value stringByAppendingString:@"¥"];
            }
            else if ([strChar isEqualToString:@"11111001"])
            {
                value=[value stringByAppendingString:@"•"];
            }
            else if ([strChar isEqualToString:@"10000000"])
            {
                value=[value stringByAppendingString:@"€"];
            }
            else if ([strChar isEqualToString:@"00001010"])
            {
                value=[value stringByAppendingString:@"\n"];
            }
            else
            {
                value=@"";
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error: Invalid input!" message:nil delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                [alert show];
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
