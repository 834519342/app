//
//  AppDelegate.m
//  app
//
//  Created by 谭杰 on 2016/12/15.
//  Copyright © 2016年 谭杰. All rights reserved.
//

#import "AppDelegate.h"

#import "TJLocalPush.h"

#import "ViewController.h"
#import "LeftSlidingMenuVC.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@property (nonatomic, strong) MMDrawerController *drawerController;

@property (nonatomic, strong) LeftSlidingMenuVC *leftSlidingMenuVC;

@property (nonatomic, strong) ViewController *homeVC;


@end

@implementation AppDelegate
//willFinishLaunchingWithOptions
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions {
    self.leftSlidingMenuVC = [[LeftSlidingMenuVC alloc] init];
    
    self.homeVC = [[ViewController alloc] init];
    
    UINavigationController *leftNavC = [[UINavigationController alloc] initWithRootViewController:self.leftSlidingMenuVC];
    leftNavC.navigationBar.translucent = NO;
    
    UINavigationController *centerNavC = [[UINavigationController alloc] initWithRootViewController:self.homeVC];
    centerNavC.navigationBar.translucent = NO;
    
    //实例化
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:centerNavC leftDrawerViewController:leftNavC];
    //设置显示阴影
    [self.drawerController setShowsShadow:YES];
    //设置最大左抽屉宽度
    [self.drawerController setMaximumLeftDrawerWidth:280.0];
    //设置打开抽屉手势
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    //设置关闭抽屉手势
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    UIColor * tintColor = [UIColor colorWithRed:29.0/255.0
                                          green:173.0/255.0
                                           blue:234.0/255.0
                                          alpha:1.0];
    [self.window setTintColor:tintColor];
    [self.window setRootViewController:self.drawerController];
    
    return YES;
}

//didFinishLaunchingWithOptions
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [TJLocalPush registLocalNotificationWithDelegate:self withCompletionHandler:^(BOOL granted, NSError *error) {
        
        NSLog(@"iOS10:granted:%i error:%@",granted,error);
    }];
    
    //    [TJLocalPush registLocalNotificationSuccess:^(BOOL success, NSError *error) {
    //
    //        NSLog(@"iOS9:success:%i",success);
    //    }];
    
    return YES;
}


- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    NSLog(@"iOS9Push注册成功");
}

- (void) application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"iOS9Push:%@",notification.alertBody);
    
    [TJLocalPush removeLocalNotification:notification];
}


#pragma mark - UNUserNotificationCenterDelegate
//前台即将显示推送
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler __IOS_AVAILABLE(10.0) __TVOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0)
{
    //1. 处理通知
    
    //2. 处理完成后条用 completionHandler ，用于指示在前台显示通知的形式
    completionHandler(UNNotificationPresentationOptionBadge |
                      UNNotificationPresentationOptionSound |
                      UNNotificationPresentationOptionAlert);
}

//后台推送点击通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler __IOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0) __TVOS_PROHIBITED
{
    completionHandler(UNNotificationPresentationOptionBadge |
                      UNNotificationPresentationOptionSound |
                      UNNotificationPresentationOptionAlert);
    NSLog(@"iOS10及以上版本推送");
}


- (UIViewController *)homeVC
{
    if (_homeVC == nil) {
        _homeVC = [[ViewController alloc] init];
    }
    return _homeVC;
}

- (UIViewController *)leftSlidingMenuVC
{
    if (_leftSlidingMenuVC == nil) {
        _leftSlidingMenuVC = [[LeftSlidingMenuVC alloc] init];
    }
    return _leftSlidingMenuVC;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

#pragma mark 进入前台后设置消息信息
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    //进入前台取消应用消息图标
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
