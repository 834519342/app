//
//  define.h
//  app
//
//  Created by 谭杰 on 2016/12/15.
//  Copyright © 2016年 谭杰. All rights reserved.
//

#ifndef define_h
#define define_h


#endif /* define_h */

#import "AppDelegate.h"

//AppDelegate代理权限
#define appDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

//1.获取屏幕宽度与高度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//-屏幕分辨率比例 @1x,@2x,@3x
#define ScreenScale [UIScreen mainScreen].scale
//-获取视图View大小
#define VIEW_WIDTH (self.view.frame.size.width)
#define VIEW_HEIGHT (self.view.frame.size.height)
