//
//  TJAlert.m
//  app
//
//  Created by 谭杰 on 2017/1/7.
//  Copyright © 2017年 谭杰. All rights reserved.
//

#import "TJAlert.h"

@interface TJAlert ()

@end

@implementation TJAlert
//居中显示
- (instancetype)initShowCenterWithText:(NSString *)text {
    
    self = [super init];
    if (self) {
        self.text = [text copy];
        
        UIFont *font = [UIFont boldSystemFontOfSize:16.f];
        CGSize textSize = [text boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width + 20, textSize.height + 20)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = font;
        textLabel.text = text;
        textLabel.numberOfLines = 0;
        
        self.contentView = [[UIButton alloc] initWithFrame:textLabel.bounds];
        self.contentView.layer.cornerRadius = 5.f;
        //打开圆角效果
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.borderWidth = 1.f;
        self.contentView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
        self.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        [self.contentView addSubview:textLabel];
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.contentView addTarget:self action:@selector(alertTaped:) forControlEvents:UIControlEventTouchDown];
        self.contentView.alpha = 0.f;
        
        self.duration = DEFAULT_DISPLAY_DURATION;
    }
    
    return self;
}



//居中显示
+ (void)showCenterWithText:(NSString *)text
{
    [self showCenterWithText:text duration:DEFAULT_DISPLAY_DURATION];
}

//居中显示
+ (void)showCenterWithText:(NSString *)text duration:(CGFloat)duration
{
    TJAlert *alert = [[TJAlert alloc] initShowCenterWithText:text];
    [alert setDuration:duration];
    [alert showCenter];
}

//显示提示框，带动画
- (void)showCenter
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.contentView.center = window.center;
    [window addSubview:self.contentView];
    [self showAnimationSetAlpha];
    [self performSelector:@selector(hideAnimationSetAlpha) withObject:nil afterDelay:self.duration];
}

//动画改变提示框透明度
- (void)showAnimationSetAlpha
{
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.alpha = 1.0;
    }];
}

//点击提示框移除对话框
- (void)alertTaped:(UIButton *)btn
{
    [self hideAnimationSetAlpha];
}

//动画改变透明度，再移除对象
- (void)hideAnimationSetAlpha
{
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self dismissAlert];
    }];
}

//移除对象
- (void)dismissAlert
{
    [self.contentView removeFromSuperview];
}

//顶端显示
- (instancetype)initShowTopWithText:(NSString *)text
{
    self = [super init];
    if (self) {
        self.text = [text copy];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, ScreenWidth - 40, 44)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.font = [UIFont boldSystemFontOfSize:14.f];
        textLabel.text = self.text;
        textLabel.numberOfLines = 0;
        
        self.contentView = [[UIButton alloc] initWithFrame:CGRectMake(10, -54, ScreenWidth - 20, 54)];
        self.contentView.layer.cornerRadius = 8.f;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
        self.contentView.layer.borderWidth = 1.f;
        self.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        [self.contentView addSubview:textLabel];
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [self.contentView addTarget:self action:@selector(hideTopAnimation) forControlEvents:UIControlEventTouchDown];
        
    }
    return self;
}

//顶端显示
+ (void)showTopWithText:(NSString *)text
{
    [self showTopWithText:text duration:DEFAULT_DISPLAY_DURATION];
}

//顶端显示
+ (void)showTopWithText:(NSString *)text duration:(CGFloat)duration
{
    TJAlert *tjAlert = [[TJAlert alloc] initShowTopWithText:text];
    [tjAlert setDuration:duration];
    [tjAlert showTop];
}

//顶端显示，带动画
- (void)showTop
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.contentView.frame = CGRectMake(10, -54, ScreenWidth - 20, 54);
    [window addSubview:self.contentView];
    [self showTopAnimation];
    [self performSelector:@selector(hideTopAnimation) withObject:nil afterDelay:self.duration];
}

//显示动画
- (void)showTopAnimation
{
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.frame = CGRectMake(10, 20, ScreenWidth - 20, 54);
    }];
}

//隐藏动画
- (void)hideTopAnimation
{
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.frame = CGRectMake(10, -54, ScreenWidth - 20, 54);
    } completion:^(BOOL finished) {
        [self dismissAlert];
    }];
}


@end
