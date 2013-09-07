//
//  HexBTAppDelegate.m
//  HexBT
//
//  Created by Pan Ziyue on 5/8/13.
//  Copyright (c) 2013 Pan Ziyue. All rights reserved.
//

#import "HexBTAppDelegate.h"
#import "WCAlertView.h"

@implementation HexBTAppDelegate

@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self initializeStoryBoardBasedOnScreenSize];
    //Set tab bar looks
    [[UITabBar appearance] setTintColor:[UIColor colorWithWhite:1.0 alpha:0.8]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor colorWithRed:158.0/255.0 green:158.0/255.0 blue:158.0/255.0 alpha:1.0] }forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor colorWithRed:132.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0] }forState:UIControlStateSelected];
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor colorWithRed:0.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabBarPic.png"]];
    
    //Set tab bar icons
    self.tabBarController = (UITabBarController*)self.window.rootViewController;
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
    
    [WCAlertView setDefaultStyle:WCAlertViewStyleWhite];
    [WCAlertView setDefaultCustomiaztonBlock:^(WCAlertView *alertView){
        alertView.labelTextColor=[UIColor darkTextColor];
        /*UIColor *topGradient = [UIColor clearColor];
        UIColor *middleGradient = [UIColor clearColor];
        UIColor *bottomGradient = [UIColor clearColor];
        alertView.gradientColors = @[topGradient,middleGradient,bottomGradient];*/
        alertView.innerFrameStrokeColor = [UIColor clearColor];
        alertView.outerFrameColor = [UIColor clearColor];
        alertView.buttonTextColor=[UIColor darkTextColor];
        alertView.buttonFont=[UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        alertView.titleFont=[UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        alertView.cornerRadius=7.0f;
    }];
    
    return YES;
}

-(void)initializeStoryBoardBasedOnScreenSize {
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
    {    // The iOS device = iPhone or iPod Touch
        
        
        CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
        
        if (iOSDeviceScreenSize.height == 480)
        {   // iPhone 3GS, 4, and 4S and iPod Touch 3rd and 4th generation: 3.5 inch screen (diagonally measured)
            
            // Instantiate a new storyboard object using the storyboard file named Storyboard_iPhone35
            UIStoryboard *iPhone35Storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            
            // Instantiate the initial view controller object from the storyboard
            UIViewController *initialViewController = [iPhone35Storyboard instantiateInitialViewController];
            
            // Instantiate a UIWindow object and initialize it with the screen size of the iOS device
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            
            // Set the initial view controller to be the root view controller of the window object
            self.window.rootViewController  = initialViewController;
            
            // Set the window object to be the key window and show it
            [self.window makeKeyAndVisible];
        }
        
        if (iOSDeviceScreenSize.height == 568)
        {   // iPhone 5 and iPod Touch 5th generation: 4 inch screen (diagonally measured)
            
            // Instantiate a new storyboard object using the storyboard file named Storyboard_iPhone4
            UIStoryboard *iPhone4Storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard-568h" bundle:nil];
            
            // Instantiate the initial view controller object from the storyboard
            UIViewController *initialViewController = [iPhone4Storyboard instantiateInitialViewController];
            
            // Instantiate a UIWindow object and initialize it with the screen size of the iOS device
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            
            // Set the initial view controller to be the root view controller of the window object
            self.window.rootViewController  = initialViewController;
            
            // Set the window object to be the key window and show it
            [self.window makeKeyAndVisible];
        }
        
    } else if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
        
    {   // The iOS device = iPad
        
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
        
    }
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
