//
//  AppDelegate.m
//  NotificationWatchKit12
//
//  Created by MAEDAHAJIME on 2015/05/27.
//  Copyright (c) 2015年 MAEDAHAJIME. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // ローカル通知を動作させる許可を得る必要 ユーザーに許可を貰う処理
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil]];
    }
    
    return YES;
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

/* ============================================================================== */
#pragma mark - UILocalNotification
/* ============================================================================== */
// 通常、アプリケーションが起動中の場合はローカル通知は通知されないが、通知されるようにする
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if(notification) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"セミナー通知のご案内"
                              message:@"大阪心斎橋Appleセンターで開催します。"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}


@end
