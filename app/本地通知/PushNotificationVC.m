//
//  PushNotificationVC.m
//  app
//
//  Created by 谭杰 on 2017/1/12.
//  Copyright © 2017年 谭杰. All rights reserved.
//

#import "PushNotificationVC.h"
#import "TJLocalPush.h"

@interface PushNotificationVC ()

@end

@implementation PushNotificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"本地推送";
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
    [btn1 setTitle:@"iOS9推送" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(iOS9Push:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame = CGRectMake(0, 60, self.view.frame.size.width, 40);
    [btn2 setTitle:@"iOS10推送" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(iOS10Push:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)iOS9Push:(UIButton *)btn
{
    TJNotificationModel *model = [[TJNotificationModel alloc] init];
    model.title = @"iOS9Push";
    model.body = @"iOS9PushMessage";
    model.timeInterval = 10;
    model.userInfo = @{@"a":@"a"};
    
    [TJLocalPush pushLocalNotificationModel:model NotificationInfo:^(BOOL success, UILocalNotification *localNotification) {
        
        NSLog(@"iOS9Push:error = %i",success);
    }];
}

- (void)iOS10Push:(UIButton *)btn
{
    TJNotificationModel *model = [[TJNotificationModel alloc] init];
    model.title = @"iOS10Push";
    model.body = @"iOS10PushMessage";
    model.timeInterval = 10;
    model.userInfo = @{@"b":@"b"};
    
    [TJLocalPush pushLocalNotificationModel:model withCompletionHandler:^(NSError *error) {
        NSLog(@"iOS10Push:error = %@",error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
