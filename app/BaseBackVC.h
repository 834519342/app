//
//  BaseBackVC.h
//  app
//
//  Created by admin on 2017/2/21.
//  Copyright © 2017年 谭杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseBackVC : UIViewController

@property (nonatomic, strong) NSString *backTitle;

//左菜单
- (void)backVC:(UIBarButtonItem *)sender;

@end
