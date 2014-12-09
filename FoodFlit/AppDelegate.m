//
//  AppDelegate.m
//  FoodFlit
//
//  Created by Student on 11/18/14.
//  Copyright (c) 2014 tjbanddom. All rights reserved.
//

#import "AppDelegate.h"
#import "GlobeVC.h"
#import "Recipe.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //Somewhat temporary. Need to figure out a way to pass recipes to GlobeVC class, and also
    //need to figure out how to update recipes for GlobeVC
    // Override point for customization after application launch.
    self.recipes = [NSMutableArray array];
    
    NSMutableArray *tempRecipes = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"thefavoriteslist"]];
    self.recipes = [[NSMutableArray alloc]init];
    for(NSString *recID in tempRecipes){
        Recipe *rec = [[Recipe alloc]initWithID:recID];
        [self.recipes addObject:rec];
    }

    //CHECK IF PARKS WERE CREATED PROPERLY THIS IS IN CAPS IM SORRY
    for (Recipe *park in self.recipes){
        NSLog(@"park=%@",park);
        NSLog(@"Recipe Name:%@", park.recipeName);
        NSLog(@"Recipe Location:%@", park.location);
    }
    
    self.tabBarController = (UITabBarController *)self.window.rootViewController;
    UINavigationController *navVC = (UINavigationController *) [[self.tabBarController viewControllers] objectAtIndex:3];
    GlobeVC *myMapVC = (GlobeVC *)[[navVC viewControllers] objectAtIndex:0];
    myMapVC.recipes = self.recipes;
    return YES;
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
