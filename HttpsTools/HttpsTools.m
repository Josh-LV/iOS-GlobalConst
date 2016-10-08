//
//  HttpsTools.m
//  yyt
//
//  Created by Yunyi on 16/5/11.
//  Copyright © 2016年 yunyiChina. All rights reserved.
//

#import "HttpsTools.h"
#import <AFNetworking.h>

@implementation HttpsTools

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    NSURLSession *session = [NSURLSession sharedSession];
    [session invalidateAndCancel];
    NSURL *url1 = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url1];
    request.HTTPMethod = @"GET";
    
    if(params != NULL && params.count != 0){
        NSMutableString *body = [NSMutableString string];
        int count = 0;
        for (id key in params) {
            if (count == params.count - 1) {
                [body appendFormat:@"%@=%@",key,params[key]];
            }else{
                [body appendFormat:@"%@=%@&",key,params[key]];
            }
            count ++;
        }
        request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                failure(error);
            }else{
                success(data);
            }
        });
    }];
    [task resume];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    NSURLSession *session = [NSURLSession sharedSession];
    [session invalidateAndCancel];
    NSURL *url1 = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url1];
    request.HTTPMethod = @"POST";
    
    
    if(params != NULL && params.count != 0){
        NSMutableString *body = [NSMutableString string];
        int count = 0;
        for (id key in params) {
            if (count == params.count - 1) {
                [body appendFormat:@"%@=%@",key,params[key]];
            }else{
                [body appendFormat:@"%@=%@&",key,params[key]];
            }
            count ++;
        }
        request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                failure(error);
            }else{
                success(data);
            }
        });
    }];
    [task resume];
}

@end
