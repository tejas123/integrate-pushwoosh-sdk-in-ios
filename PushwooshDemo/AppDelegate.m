//
//  AppDelegate.m
//  PushwooshDemo
//
//  Created by TheAppGuruz-iOS-103 on 25/02/16.
//  Copyright © 2016 TheAppGuruz. All rights reserved.
//

#import "AppDelegate.h"
#import <Pushwoosh/PushNotificationManager.h>

@import CoreLocation;
@import SystemConfiguration;
@import AVFoundation;
@import ImageIO;

@interface AppDelegate () <PushNotificationDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //-----------PUSHWOOSH PART-----------
    // set custom delegate for push handling, in our case - view controller
    PushNotificationManager * pushManager = [PushNotificationManager pushManager];
    pushManager.delegate = self;
    
    // handling push on app start
    [[PushNotificationManager pushManager] handlePushReceived:launchOptions];
    
    // make sure we count app open in Pushwoosh stats
    [[PushNotificationManager pushManager] sendAppOpen];
    
    // register for push notifications!
    [[PushNotificationManager pushManager] registerForPushNotifications];
    
    return YES;
}

// system push notification registration success callback, delegate to pushManager
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[PushNotificationManager pushManager] handlePushRegistration:deviceToken];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Device Token" message:[NSString stringWithFormat:@"didRegisterForRemoteNotificationsWithDeviceToken : %@", deviceToken] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:alertAction];
        
        [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    });
}

// system push notification registration error callback, delegate to pushManager
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [[PushNotificationManager pushManager] handlePushRegistrationFailure:error];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Fail Register" message:[NSString stringWithFormat:@"didFailToRegisterForRemoteNotificationsWithError : %@", error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:alertAction];
        
        [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    });
}

// system push notifications callback, delegate to pushManager
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[PushNotificationManager pushManager] handlePushReceived:userInfo];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Receive Notification" message:[NSString stringWithFormat:@"didReceiveRemoteNotification : %@", userInfo] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:alertAction];
        
        [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    });
}

- (void) onPushAccepted:(PushNotificationManager *)pushManager withNotification:(NSDictionary *)pushNotification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Push Notification" message:[NSString stringWithFormat:@"onPushAccepted : %@", pushNotification] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:alertAction];
        
        [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    });
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
