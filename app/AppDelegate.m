//
//  AppDelegate.m
//  app
//
//  Created by 谭杰 on 2016/12/15.
//  Copyright © 2016年 谭杰. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "LeftSlidingMenuVC.h"

@interface AppDelegate ()

@property (nonatomic, strong) MMDrawerController *drawerController;

@property (nonatomic, strong) LeftSlidingMenuVC *leftSlidingMenuVC;

@property (nonatomic, strong) ViewController *homeVC;

@end

@implementation AppDelegate

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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
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
