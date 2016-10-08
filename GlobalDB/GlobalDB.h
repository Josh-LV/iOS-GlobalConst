//
//  GlobalDB.h
//  yyt
//
//  Created by Yunyi on 2016/6/23.
//  Copyright © 2016年 yunyiChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalDB : NSObject
/**
 *  创建表
 */
+ (instancetype)sharedFMDBToolWithName:(NSString *)dbName;
/**
 *  查询数据
 */
-(NSArray *)selectDBName:(NSString *)dbName;
/**
 *  插入数据到相应表
 */
- (void)insertDBName:(NSString *)dbName CashData:(NSString *)cashData;
/**
 *  删除相应表中数据
 */
- (void)deleteDBName:(NSString *)dbName;

- (void)colseDB;

@end
