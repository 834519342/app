//
//  TJDB.m
//  TJSqliteData
//
//  Created by 谭杰 on 2017/1/16.
//  Copyright © 2017年 谭杰. All rights reserved.
//

#import "TJDB.h"
#import <sqlite3.h>
#import <objc/runtime.h>

@interface TJDB ()
{
    sqlite3 *db;
}

@end

@implementation TJDB

- (instancetype)initWithDBName:(NSString *)dbName TableName:(NSString *)tableName
{
    self = [super init];
    self.dbName = dbName;
    if (![self createDBTable:tableName]) {
        return nil;
    }
    if (self) {
        self.tableName = tableName;
    }
    return self;
}

//创建/打开数据库
- (BOOL)openDB
{
    //获取数据库位置
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:self.dbName];
    
    //如果数据库存在,则用sqlite3_open直接打开(数据库不存在则会自动创建)
    //打开数据库,这里的[path UTF8String]是将NSString转换为C字符串,因为SQLite3是采用可移植的C(不是OC)编写的,它不知道什么是NSString.
    if (sqlite3_open([database_path UTF8String], &db) == SQLITE_OK) {
        return YES;
    }else {
        sqlite3_close(db);
        return NO;
    }
}

//创建数据库表
- (BOOL)createDBTable:(NSString *)tableName
{
    //sql 命令语句
    NSString *createTableSql = [NSString stringWithFormat:@"create table if not exists %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT, %@ text, %@ int, %@ float)",tableName,[self getPropertyNameList][0],[self getPropertyNameList][1],[self getPropertyNameList][2],[self getPropertyNameList][3]];
    
    return [self execSql:createTableSql];
}

//插入一个数据
- (BOOL)insertData:(DataModel *)dataModel TableName:(NSString *)tableName
{
    //sql 命令语句
    NSString *insertSql = [NSString stringWithFormat:@"insert into %@ (%@,%@,%@) values ('%@','%d','%f')",tableName,[self getPropertyNameList][1],[self getPropertyNameList][2],[self getPropertyNameList][3],dataModel.name,dataModel.age,dataModel.weight];
    
    return [self execSql:insertSql];
}

//更新一个数据
- (BOOL)updateData:(DataModel *)dataModel TableName:(NSString *)tableName
{
    NSString *updateSql = [NSString stringWithFormat:@"update %@ set %@ = '%@',%@ = '%d',%@ = '%f' where (%@ = '%d')",tableName,[self getPropertyNameList][1],dataModel.name,[self getPropertyNameList][2],dataModel.age,[self getPropertyNameList][3],dataModel.weight,[self getPropertyNameList][0],dataModel.dataId];
    
    return [self execSql:updateSql];
}

//删除一个数据
- (BOOL)deleteData:(DataModel *)dataModel TableName:(NSString *)tableName
{
    NSString *deleteSql = [NSString stringWithFormat:@"delete from %@ where %@ = '%d'",tableName,[self getPropertyNameList][0],dataModel.dataId];
    
    return [self execSql:deleteSql];
}

//删除数据库表
- (BOOL)deleteTable:(NSString *)tableName
{
    NSString *deleteTableSql = [NSString stringWithFormat:@"delete from %@",tableName];
    return [self execSql:deleteTableSql];
}

//获取一个数据
- (DataModel *)getData:(DataModel *)dataModel Table:(NSString *)tableName
{
    if (![self openDB]) {
        return nil;
    }
    NSString *querySql = [NSString stringWithFormat:@"select * from %@ where %@ = '%d'",tableName,[self getPropertyNameList][0],dataModel.dataId];
    
    sqlite3_stmt *statement;
    DataModel *dataModel1 = [[DataModel alloc] init];;
    
    if (sqlite3_prepare_v2(db, [querySql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        //查询结果中便利所有的记录，这里的数字对应列值，注意列值
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            dataModel1.dataId = sqlite3_column_int(statement, 0);
            dataModel1.name = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
            dataModel1.age = sqlite3_column_int(statement, 2);
            dataModel1.weight = sqlite3_column_double(statement, 3);
        }
    }else {
        sqlite3_finalize(statement);
        sqlite3_close(db);
        return nil;
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(db);
    return dataModel1;
}

//获取所有用户
- (NSArray *)getAllDataTableName:(NSString *)tableName
{
    if (![self openDB]) {
        return nil;
    }
    
    NSString *queryAllSql = [NSString stringWithFormat:@"select * from %@",tableName];
    sqlite3_stmt *statement;
    
    NSMutableArray *allData = [NSMutableArray array];
    
    if (sqlite3_prepare_v2(db, [queryAllSql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        //查询结果中便利所有记录,这里的数字对应的是列值
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            @autoreleasepool {
                DataModel *dataModel = [[DataModel alloc] init];
                dataModel.dataId = sqlite3_column_int(statement, 0);
                dataModel.name = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                dataModel.age = sqlite3_column_int(statement, 2);
                dataModel.weight = sqlite3_column_double(statement, 3);
                
                [allData addObject:dataModel];
            }
        }
    }else {
        sqlite3_finalize(statement);
        sqlite3_close(db);
        return nil;
    }
    sqlite3_finalize(statement);
    sqlite3_close(db);
    return allData;
}

//执行命令
- (BOOL)execSql:(NSString *)sql
{
    if (![self openDB]) {
        return NO;
    }
    char *error;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &error) != SQLITE_OK) {
        sqlite3_close(db); //关闭数据库
        sqlite3_free(error); //释放错误信息
        return NO;
    }else {
        sqlite3_close(db); //关闭数据库
        sqlite3_free(error); //释放错误信息
        return YES;
    }
}

//获取类所有属性名
- (NSArray *)getPropertyNameList{
    
    u_int count = 0;
    
    objc_property_t *property = class_copyPropertyList([DataModel class], &count);
    
    NSMutableArray *propertyNameArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i=0; i<count; i++){
        
        const char* propertyName =property_getName(property[i]);
        
        [propertyNameArray addObject: [NSString stringWithUTF8String:propertyName]];
    }
    
    free(property);
    
    return propertyNameArray;
}

@end
