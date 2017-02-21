//
//  BaseBackVC.h
//  app
//
//  Created by admin on 2017/2/21.
//  Copyright © 2017年 谭杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseBackVC : UIViewController

//返回按钮文本内容
@property (nonatomic, strong) NSString *backTitle;

//返回按钮事件
- (void)backVC:(UIBarButtonItem *)sender;

@end
