//
//  FPAppDelegate.m
//  FPThemeKit
//
//  Created by fanpeng on 06/18/2025.
//  Copyright (c) 2025 fanpeng. All rights reserved.
//

#import "FPAppDelegate.h"
#import <FPThemeKit/FPThemeKit.h>
@implementation FPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSMapTable *mapTable = [NSMapTable weakToStrongObjectsMapTable];
    NSObject *key = [[NSObject alloc] init];
    NSObject *value = [[NSObject alloc] init];
    [mapTable setObject:value forKey:key];
    NSLog(@"键对应的值: %@", [mapTable objectForKey:key]); // 输出: 键对应的值: (null)

    // 当键对象被释放（例如设置为 nil 且没有其他引用）,
    // 该条目会自动从 mapTable 中移除。
    key = nil;
    NSLog(@"键对应的值: %@", [mapTable objectForKey:key]); // 输出: 键对应的值: (null)
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
