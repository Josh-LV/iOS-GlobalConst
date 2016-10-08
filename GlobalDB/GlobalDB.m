//
//  GlobalDB.m
//  yyt
//
//  Created by Yunyi on 2016/6/23.
//  Copyright © 2016年 yunyiChina. All rights reserved.
//

#import "GlobalDB.h"
#import "FMDB.h"
#import "YYTUserInfo.h"

@interface GlobalDB ()

@property(nonatomic, strong) FMDatabase *fmDB;

@end

@implementation GlobalDB

static GlobalDB *_instance;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
        
    });
    
    return _instance;
}

+ (instancetype)sharedFMDBToolWithName:(NSString *)dbName
{
    if (_instance == nil) {
        _instance = [[GlobalDB alloc] init];
        [_instance creatDBWithName:dbName];
    }else{
        [_instance creatDBWithName:dbName];
    }
    
    return _instance;
}

- (void)creatDBWithName:(NSString *)dbName
{
    YYTUserInfo *info = [YYTUserInfo sharedYYTUserInfo];
    [info loadUserInfoFromSanbox];
    NSString *dbNa = [NSString stringWithFormat:@"%@.db",info.userId];
    NSLog(@"%@",dbNa);
    //数据库文件路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingString:@"/UserCash"];
    
    NSFileManager *mg = [NSFileManager defaultManager];
    if (![mg fileExistsAtPath:file]) {
        [mg createDirectoryAtPath:file withIntermediateDirectories:true attributes:nil error:nil];
    }
    
    NSString *fileName = [file stringByAppendingPathComponent:dbNa];
    
    //获取数据库
    if (_fmDB == nil) {
        FMDatabase *db = [FMDatabase databaseWithPath:fileName];
        //打开表
        if ([db open]) {
            //创建表
            NSString *tb = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY AUTOINCREMENT, cashData text);",dbName];
            bool result = [db executeUpdate:tb];
            if (result) {
                _fmDB = db;
            }
        }
    }else{
        NSString *tb = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY AUTOINCREMENT, cashData text);",dbName];
        bool result = [_fmDB executeUpdate:tb];
    }
}
- (void)insertDBName:(NSString *)dbName CashData:(NSString *)cashData
{
    BOOL b = [_fmDB executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@ (cashData) VALUES ('%@')", dbName, cashData]];
    NSLog(@"%d",b);
}
- (void)deleteDBName:(NSString *)dbName
{
    [self.fmDB executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@", dbName]];
}
//查询
-(NSArray *)selectDBName:(NSString *)dbName
{
    FMResultSet *resultSet = [_fmDB executeQuery:[NSString stringWithFormat:@"select * from %@",dbName]];
    NSMutableArray *array = [NSMutableArray array];
    while ([resultSet next]) {
        NSString *cashData = [resultSet objectForColumnName:@"cashData"];
        [array addObject:cashData];
    }
    return array;
}
- (void)colseDB
{
    [self.fmDB close];
    self.fmDB = nil;
}
@end
