//
//  TJAlert.h
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


typedef void(^ClickAlertBlock)(NSString *message);

@interface TJAlert : NSObject

//代理回传
@property (nonatomic, weak) id<TJAlertDelegate> delegate;

//block回调
@property (nonatomic, copy) ClickAlertBlock clickAlertBlock;

//提示内容
@property (nonatomic, copy) NSString *message;

//容器视图
@property (nonatomic, strong) UIButton *contentView;

//显示时间
@property (nonatomic, assign) CGFloat duration;


/** 居中显示提示框
 * @param message 提示内容
 */
+ (void)showCenterWithMessage:(NSString *)message;

/** 居中显示提示框
 * @param message 提示内容
 * @param duration 显示时间
 */
+ (void)showCenterWithMessage:(NSString *)message duration:(CGFloat)duration;


/** 顶端显示提示框
 *  @param message 提示内容
 *  @param delegate 代理
 */
+ (void)showTopWithMessage:(NSString *)message withDelegate:(id)delegate;

/** 顶端显示提示框
 *  @param message 提示内容
 *  @param duration 显示时间
 *  @param delegate 代理
 */
+ (void)showTopWithMessage:(NSString *)message duration:(CGFloat)duration withDelegate:(id)delegate;

/** 顶端显示提示框
 *  @param message 提示内容
 *  @param clickAlertBlock 点击Alert回调
 */
+ (void)showTopWithMessage:(NSString *)message clickAlertBlock:(ClickAlertBlock)clickAlertBlock;

/** 顶端显示提示框
 *  @param message 提示内容
 *  @param duration 显示时间
 *  @param clickAlertBlock 点击Alert回调
 */
+ (void)showTopWithMessage:(NSString *)message duration:(CGFloat)duration clickAlertBlock:(ClickAlertBlock)clickAlertBlock;

@end
