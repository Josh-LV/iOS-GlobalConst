//
//  HttpsTools.h
//  yyt
//
//  Created by Yunyi on 16/5/11.
//  Copyright © 2016年 yunyiChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpsTools : NSObject
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
