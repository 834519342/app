//
//  DataModel.h
//  TJSqliteData
//
//  Created by 谭杰 on 2017/1/16.
//  Copyright © 2017年 谭杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic, assign) int dataId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) int age;

@property (nonatomic, assign) float weight;

@end
