//
//  TJAlertView.h
//  app
//
//  Created by 谭杰 on 2017/1/7.
//  Copyright © 2017年 谭杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Masonry.h"

//获取屏幕宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
//默认显示时间
#define DEFAULT_DISPLAY_DURATION 2.f

@protocol TJAlertDelegate <NSObject>

//点击顶部提示框
- (void)ClickTopAlertText:(NSString *)text;

@end


@interface TJAlert : NSObject

//代理回传
@property (nonatomic, weak) id<TJAlertDelegate> delegate;

//提示内容
@property (nonatomic, copy) NSString *text;

//容器视图
@property (nonatomic, strong) UIButton *contentView;

//显示时间
@property (nonatomic, assign) CGFloat duration;


//居中显示
+ (void)showCenterWithText:(NSString *)text;

/** 显示text, 经duration时间后移除 */
+ (void)showCenterWithText:(NSString *)text duration:(CGFloat)duration;


//顶端显示
+ (void)showTopWithText:(NSString *)text withDelegate:(id)delegate;

+ (void)showTopWithText:(NSString *)text duration:(CGFloat)duration withDelegate:(id)delegate;

@end
