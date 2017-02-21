//
//  TJDB.h
//  TJSqliteData
//
//  Created by 谭杰 on 2017/1/16.
//  Copyright © 2017年 谭杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"

@interface TJDB : NSObject

@property (nonatomic, copy) NSString *dbName; //数据库名字

@property (nonatomic, copy) NSString *tableName; //表名

- (instancetype)initWithDBName:(NSString *)dbName TableName:(NSString *)tableName;

//插入一个数据
- (BOOL)insertData:(DataModel *)dataModel TableName:(NSString *)tableName;

//更新一个数据
- (BOOL)updateData:(DataModel *)dataModel TableName:(NSString *)tableName;

//删除一个数据
- (BOOL)deleteData:(DataModel *)dataModel TableName:(NSString *)tableName;

//删除数据库表
- (BOOL)deleteTable:(NSString *)tableName;

//获取一个数据
- (DataModel *)getData:(DataModel *)dataModel Table:(NSString *)tableName;

//获取所有用户
- (NSArray *)getAllDataTableName:(NSString *)tableName;

@end
