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
- (instancetype)initShowCenterWithMessage:(NSString *)message {
    
    self = [super init];
    if (self) {
        self.message = [message copy];
        self.duration = DEFAULT_DISPLAY_DURATION;
        
        UIFont *font = [UIFont boldSystemFontOfSize:16.f];
        CGSize textSize = [message boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
        
        self.contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textSize.width + 20, textSize.height + 20)];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.contentView.layer.shadowOffset = CGSizeMake(0, 0);
        self.contentView.layer.shadowRadius = 5.f;
        self.contentView.layer.shadowOpacity = 0.8;
        self.contentView.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.8].CGColor;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.contentView addTarget:self action:@selector(hideAnimationSetAlpha) forControlEvents:UIControlEventTouchDown];
        self.contentView.alpha = 0.f;
        
        
        UIView *yuanjiaoView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        yuanjiaoView.userInteractionEnabled = NO;
        [self.contentView addSubview:yuanjiaoView];
        yuanjiaoView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        yuanjiaoView.layer.cornerRadius = 8.f;
        yuanjiaoView.layer.masksToBounds = YES;
        
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:textLabel];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = font;
        textLabel.text = message;
        textLabel.numberOfLines = 0;

        //监听屏幕方向改变的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChanged:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
    }
    
    return self;
}

- (void)deviceOrientationDidChanged:(NSNotification *)aNotification
{
    [self hideAnimationSetAlpha];
}

//居中显示
+ (void)showCenterWithMessage:(NSString *)message
{
    [self showCenterWithMessage:message duration:DEFAULT_DISPLAY_DURATION];
}

//居中显示
+ (void)showCenterWithMessage:(NSString *)message duration:(CGFloat)duration
{
    TJAlert *alert = [[TJAlert alloc] initShowCenterWithMessage:message];
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
- (instancetype)initShowTopWithMessage:(NSString *)message
{
    self = [super init];
    if (self) {
        self.message = [message copy];
        self.duration = DEFAULT_DISPLAY_DURATION;
        
        self.contentView = [[UIButton alloc] initWithFrame:CGRectMake(10, -54, ScreenWidth - 20, 54)];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.contentView.layer.shadowOffset = CGSizeMake(0, 0); //阴影方向
        self.contentView.layer.shadowRadius = 5.f; //阴影宽度
        self.contentView.layer.shadowOpacity = 0.8; //阴影强度
        self.contentView.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.8].CGColor; //阴影颜色
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [self.contentView addTarget:self action:@selector(tapTop:) forControlEvents:UIControlEventTouchDown];
        
        
        UIView *yuanjiaoView = [UIView new];
        [self.contentView addSubview:yuanjiaoView];
        [yuanjiaoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top);
            make.left.mas_equalTo(self.contentView.mas_left);
            make.right.mas_equalTo(self.contentView.mas_right);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
        yuanjiaoView.userInteractionEnabled = NO;
        yuanjiaoView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        yuanjiaoView.layer.cornerRadius = 8.f;
        yuanjiaoView.layer.masksToBounds = YES; //圆角切割
//        yuanjiaoView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
//        yuanjiaoView.layer.borderWidth = 1.f;

        
        UILabel *textLabel = [UILabel new];
        [self.contentView addSubview:textLabel];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(5);
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
        }];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.font = [UIFont boldSystemFontOfSize:14.f];
        textLabel.text = self.message;
        textLabel.numberOfLines = 0;
        
    }
    return self;
}


//顶端显示,使用代理回调
+ (void)showTopWithMessage:(NSString *)message withDelegate:(id)delegate
{
    [self showTopWithMessage:message duration:DEFAULT_DISPLAY_DURATION withDelegate:delegate];
}

//顶端显示，代理回调
+ (void)showTopWithMessage:(NSString *)message duration:(CGFloat)duration withDelegate:(id)delegate
{
    TJAlert *tjAlert = [[TJAlert alloc] initShowTopWithMessage:message];
    if (delegate) {
        tjAlert.delegate = delegate;
    }
    [tjAlert setDuration:duration];
    [tjAlert showTop];
}

//block回调
+ (void)showTopWithMessage:(NSString *)message clickAlertBlock:(ClickAlertBlock)clickAlertBlock
{
    [self showTopWithMessage:message duration:DEFAULT_DISPLAY_DURATION clickAlertBlock:^(NSString *message) {
        if (clickAlertBlock) {
            clickAlertBlock(message);
        }
    }];
}

+ (void)showTopWithMessage:(NSString *)message duration:(CGFloat)duration clickAlertBlock:(ClickAlertBlock)clickAlertBlock
{
    TJAlert *tjAlert = [[TJAlert alloc] initShowTopWithMessage:message];
    [tjAlert setDuration:duration];
    [tjAlert showTop];
    tjAlert.clickAlertBlock = ^(NSString *message) {
        if (clickAlertBlock) {
            clickAlertBlock(message);
        }
    };
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

//点击手势
- (void)tapTop:(UIGestureRecognizer *)tap
{
    if (tap != nil) {
        [self hideTopAnimation];
        if (self.delegate) {
            [self.delegate ClickTopAlertText:self.message];
        }
        if (self.clickAlertBlock) {
            self.clickAlertBlock(self.message);
        }
    }
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

- (void)dealloc
{
    //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
}

@end
