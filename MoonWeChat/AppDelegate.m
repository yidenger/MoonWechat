//
//  AppDelegate.m
//  MoonWeChat
//
//  Created by seth on 16/3/23.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "LaunchViewController.h"
#import "EMSDK.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //统一导航栏样式
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    
    //环信
    EMOptions *options = [EMOptions optionsWithAppkey:@"moondeveloper#moonwechat"];
    options.apnsCertName = @"hehe";
    [[EMClient sharedClient]initializeSDKWithOptions:options];
    
    self.window.bounds = [[UIScreen mainScreen] bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
//    self.window.rootViewController = [[TabBarViewController alloc]init];
    
    self.window.rootViewController = [[LaunchViewController alloc]init];
    
    [self changeNav];
    
    //环信
    EMError *error = [[EMClient sharedClient] registerWithUsername:@"8001" password:@"111111"];
    if (error == nil) {
        NSLog(@"注册成功");
    }
    else{
        NSLog(@"注册失败: %@", error.errorDescription);
    }
    
    return YES;
}

//设置导航栏的样式
-(void)changeNav{

    //设置NavigaBar的背景色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:54/255.0 green:53/255.0 blue:58/255.0 alpha:1]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    //不设置这个无法修改状态栏字体的颜色
    [[UINavigationBar appearance]setBarStyle:UIBarStyleBlack];


}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [[EMClient sharedClient]applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
