//
//  AppleStorePayVC.m
//  app
//
//  Created by admin on 2017/2/15.
//  Copyright © 2017年 谭杰. All rights reserved.
//

#import "AppleStorePayVC.h"
#import "TJAppPay.h"

@interface AppleStorePayVC ()

@end

@implementation AppleStorePayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"苹果内购";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 80, 50);
    btn.center = self.view.center;
    [btn setTitle:@"苹果内购" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

- (void)click:(id)sender
{
    OrderInfo *order = [[OrderInfo alloc] init];
    order.productId = @"com.rtsapp.gold6";
    
    
    [TJAppPay buy:order completeTransaction:^(SKPaymentTransaction *transaction) {
        NSLog(@"transactionIdentifier = %ld",(long)transaction.transactionState);
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
