//
//  AppDelegate.m
//  InnerArrayDemo
//
//  Created by imac on 2017/8/29.
//  Copyright © 2017年 com.InnerArray.GodL. All rights reserved.
//

#import "AppDelegate.h"
#import "InlineArray.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSMutableArray *nsArray = [NSMutableArray array];
    InlineArray *inlineArray = [InlineArray array];
    NSInteger count = 20;
    NSData *value = nil;
    NSTimeInterval begin, end, time;
    
//    for (int i = 0; i < count; i++) {
//        NSObject *key;
//        key = @(i); // avoid string compare
//        //key = @(i).description; // it will slow down NSCache...
//        //key = [NSUUID UUID].UUIDString;
//        NSData *value = [NSData dataWithBytes:&i length:sizeof(int)];
//        [keys addObject:key];
//        [values addObject:value];
//    }
    begin = CACurrentMediaTime();
    @autoreleasepool {
        for (int i = 0; i < count; i++) {
            [nsArray addObject:@""];
        }
    }
    end = CACurrentMediaTime();
    time = end - begin;
    printf("NSArray:   %8.2f\n", time * 1000000);
    
    begin = CACurrentMediaTime();
    @autoreleasepool {
        for (int i = 0; i < count; i++) {
            [inlineArray addObject:@""];
        }
    }
    end = CACurrentMediaTime();
    time = end - begin;
    printf("inlineAray:    %8.2f\n", time * 1000000);

    begin = CACurrentMediaTime();
    @autoreleasepool {
        for (int j=0; j<100; j++) {
            for (int i = 0; i < count; i++) {
                [nsArray objectAtIndex:i];
            }
        }
    }
    end = CACurrentMediaTime();
    time = end - begin;
    printf("NSArray:   %8.2f\n", time * 1000000);
    
    
    begin = CACurrentMediaTime();
    @autoreleasepool {
        for (int j=0; j<100; j++) {
            for (int i = 0; i < count; i++) {
                [inlineArray objectAtIndex:i];
            }
        }
       
    }
    end = CACurrentMediaTime();
    time = end - begin;
    printf("inlinearray:   %8.2f\n", time * 1000000);
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
