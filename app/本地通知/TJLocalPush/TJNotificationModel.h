//
//  TJNotificationModel.h
//  TJLocalPush
//
//  Created by 谭杰 on 2017/1/13.
//  Copyright © 2017年 谭杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>


//由于iOS10推送的可更新性，还新增了一个枚举，当然，本来是不需要的，但为了测试才有的这个枚举类型
typedef NS_ENUM(NSUInteger, TJPushMessageType)
{
    TJPushMessageTypeNew = 0,     /**<默认为推送新的推送通知*/
    TJPushMessageTypeUpdate = 1,  /**<更新当前的推送通知*/
};


@interface TJNotificationModel : NSObject


@property (nonatomic, readwrite) TJPushMessageType type;


//19:共同参数，10:iOS的参数，9:iOS9的参数

//推送标题 19
@property (nonatomic, copy) NSString *title;

//推送内容 19
@property (nonatomic, copy) NSString *body;

//推送详细内容 10
@property (nonatomic, copy) NSString *subtitle;

//附带自定义信息 19
@property (nonatomic, copy) NSDictionary *userInfo;

//附带媒体信息 10
@property (nonatomic, copy) NSArray <UNNotificationAttachment *> *attachments;

//启动图 19
@property (nonatomic, copy) NSString *launchImageName;

//推送声音 19
@property (nonatomic, copy) NSString *sound;

//拓展ID 10
@property (nonatomic, copy) NSString *categoryIdentifier;

//通知数量 19
@property (nonatomic, assign) int badge;

//推送时间 19
@property (nonatomic, assign) int timeInterval;

@end
