//
//  TJAppPay.h
//  TJAppleStorePay
//
//  Created by admin on 2017/2/15.
//  Copyright © 2017年 tj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

#import "OrderInfo.h"

typedef void(^Transaction)(SKPaymentTransaction *transaction);

@interface TJAppPay : NSObject

@property (nonatomic, copy) Transaction transaction;

/** 创建支付对象
 */
+ (TJAppPay *)shardAppPay;

/** 支付
 *  @param orderInfo 订单信息
 *  @param transaction 支付返回状态
 */
+ (void)buy:(OrderInfo *)orderInfo completeTransaction:(Transaction)transaction;

@end
