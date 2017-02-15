//
//  OrderInfo.h
//  app
//
//  Created by admin on 2017/2/15.
//  Copyright © 2017年 谭杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderInfo : NSObject

/**
 *  int       goodsPrice    商品价格
 *  NSString *goodsName     商品名称
 *  NSString *goodsDesc     商品描述
 *  NSString *productId     商品ID
 *  NSString *extendInfo    扩展名称
 */

@property (nonatomic, assign) int     goodsPrice;
@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, copy) NSString *goodsDesc;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *extendInfo;

@end
