//
//  DES.h
//
//
//  Created by Josh_Lv on 16/5/23.
//  Copyright © 2016年 Josh_Lv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DES : NSObject

+ (NSString *)encryptWithText:(NSString *)sText  key:(NSString *)key;//加密
+ (NSString *)decryptWithText:(NSString *)sText  key:(NSString *)key;//解密

@end
