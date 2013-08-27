//
//  FirstTutorialViewController.m
//  HexBT
//
//  Created by Pan Ziyue on 26/8/13.
//  Copyright (c) 2013 Pan Ziyue. All rights reserved.
//

#import "FirstTutorialViewController.h"

@interface FirstTutorialViewController ()

@end

@implementation FirstTutorialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Set tab bar styles
    UITabBar *tabBar = self.tabBarController.tabBar;
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    UITabBarItem *item3 = [tabBar.items objectAtIndex:3];
    [item0 setFinishedSelectedImage:[UIImage imageNamed:@"TextToBin_Selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"TextToBin_Deselected"]];
    [item1 setFinishedSelectedImage:[UIImage imageNamed:@"TextToHex_Selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"TextToHex_Deselected.png"]];
    [item2 setFinishedSelectedImage:[UIImage imageNamed:@"TextToBase64_Selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"TextToBase64_Deselected.png"]];
    [item3 setFinishedSelectedImage:[UIImage imageNamed:@"Hash_Selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"Hash_Deselected.png"]];
    
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
    label.text = @"Text-Binary Converter";
    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
    [label setShadowColor:[UIColor whiteColor]];
    [label setShadowOffset:CGSizeMake(0, -0.5)];
    self.navigationItem.titleView = label;
}

-(IBAction)next:(id)sender
{
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
